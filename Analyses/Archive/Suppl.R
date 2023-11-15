df_ <- df %>%
       subset(df$Regulated == "Regulated",
              select = c("PID", "Event.ID", "STAI_State", "Startle_Sensitivity",
                         "HauntedHouse_Enjoyment", "TBTW_Enjoyment", "Regulated"))
df_ <- distinct(df_)

df_new <- data.frame(PID = unique(df$PID), STAI_State = NA, Startle = NA, 
                     HH.Enjoy = NA, TBTW.Enjoy = NA, Avg.Reg = NA, Events = NA)

for (ROW in 1:nrow(df_new)){
  df_new$STAI_State[ROW] <- df$STAI_State[df$PID == df_new$PID[ROW]][1]
  df_new$Startle[ROW] <- df$Startle_Sensitivity[df$PID == df_new$PID[ROW]][1]
  df_new$HH.Enjoy[ROW] <- df$HauntedHouse_Enjoyment[df$PID == df_new$PID[ROW]][1]
  df_new$TBTW.Enjoy[ROW] <- df$TBTW_Enjoyment[df$PID == df_new$PID[ROW]][1]
  df_new$Events[ROW]<- sum(df_$Regulated[df_$PID == df_new$PID[ROW]] == "Regulated")
  df_new$Avg.Reg[ROW] <- mean(df$Reg.Extent[df$PID == df_new$PID[ROW] & df$Regulated == "Regulated"])
}

df_new$STAI_State_z <- as.numeric(scale(df_new$STAI_State))
df_new$Startle_z <- as.numeric(scale(df_new$Startle))
df_new$HH.Enjoy_z <- as.numeric(scale(df_new$HH.Enjoy))
df_new$TBTW.Enjoy_z <- as.numeric(scale(df_new$TBTW.Enjoy))
df_new$Events_z <- as.numeric(scale(df_new$Events))
df_new$Avg.Reg_z <- as.numeric(scale(df_new$Avg.Reg))

summary(lm(Events ~ STAI_State_z, data = df_new))
summary(lm(Events ~ Startle_z, data = df_new))
summary(lm(Events ~ HH.Enjoy_z, data = df_new))
summary(lm(Events ~ TBTW.Enjoy_z, data = df_new))
summary(lm(Avg.Reg_z ~ STAI_State_z, data = df_new))
summary(lm(Avg.Reg_z ~ Startle_z, data = df_new))
summary(lm(Avg.Reg_z ~ HH.Enjoy_z, data = df_new))
summary(lm(Avg.Reg_z ~ TBTW.Enjoy_z, data = df_new))

plot <- ggplot(data = df_new, aes(x = STAI_State_z, y = Avg.Reg_z)) +
  stat_smooth(method="lm", alpha = .25, size = 2) +
  labs(title = "State Anxiety By Regulation Effort",
       subtitle = "B = 0.342 ; p = 0.021",
       x = paste0("State STAI (z)\n(", 
                             "mean = ",
                                    round(mean(df_new$STAI_State),1),
                                    "; sd = ",
                                    round(sd(df_new$STAI_State),1),
                             " )"), 
       y = paste0("Regulation Effort (z)\n(", 
                  "mean = ",
                  round(mean(df_new$Avg.Reg, na.rm = T),1),
                  "; sd = ",
                  round(sd(df_new$Avg.Reg, na.rm = T),1),
                  " )"),) +
  coord_cartesian(xlim=c(-2.5,2.5), ylim=c(-2, 2)) +
  theme_classic() +
  theme(legend.position="none") +
  theme(plot.title = element_text(face="bold", size=13, hjust = 0.5)) +
  theme(plot.subtitle = element_text(size = 10, hjust = 0.5, face = "italic")) +
  theme(plot.caption = element_text(size = 8, hjust = 0.0, face = "italic")) +
  theme(axis.title = element_text(size = 16)) +
  theme(axis.text.x = element_text(size = 14, color = "Black")) +
  theme(axis.text.y = element_text(size = 14, color = "Black")) 

tiff("../plots/d_RegEff_i_STAI.tiff",       
     res = 300,
     units = "in",
     width = 6, 
     height = 4.5)
plot
dev.off()

plot <- ggplot(data = df_new, aes(x = Startle_z, y = Events)) +
  stat_smooth(method="lm", alpha = .25, size = 2) +
  labs(title = "Startle Sensitivity By Events Regulated",
       subtitle = "b = 0.837 ; p = 0.034",
       x = paste0("Startle Sensitivity (z)\n(", 
                      "mean = ",
                             round(mean(df_new$Startle),1),
                             "; sd = ",
                             round(sd(df_new$Startle),1),
                             " )"), 
       y = paste0("Events Regulated")) +
  coord_cartesian(xlim=c(-2.5, 2.5), ylim=c(0,10)) +
  theme_classic() +
  theme(legend.position="none") +
  theme(plot.title = element_text(face="bold", size=13, hjust = 0.5)) +
  theme(plot.subtitle = element_text(size = 10, hjust = 0.5, face = "italic")) +
  theme(plot.caption = element_text(size = 8, hjust = 0.0, face = "italic")) +
  theme(axis.title = element_text(size = 16)) +
  theme(axis.text.x = element_text(size = 14, color = "Black")) +
  theme(axis.text.y = element_text(size = 14, color = "Black")) 

tiff("../plots/d_EvReg_i_Startle.tiff",       
    res = 300,
    units = "in",
    width = 6, 
    height = 4.5)
plot
dev.off()

plot <- ggplot(data = df_new, aes(x = HH.Enjoy_z, y = Events)) +
  stat_smooth(method="lm", alpha = .25, size = 2) +
  labs(title = "Haunted House Enjoyment By Events Regulated",
       subtitle = "b = -1.484 ; p < 0.001",
       x = paste0("Haunted House Enjoyment (z)\n(", 
                             "mean = ",
                                    round(mean(df_new$HH.Enjoy),1),
                                    "; sd = ",
                                    round(sd(df_new$HH.Enjoy),1),
                             " )"), 
       y = paste0("Events Regulated")) +
  coord_cartesian(xlim=c(-2.5,2.5), ylim=c(0,10)) +
  theme_classic() +
  theme(legend.position="none") +
  theme(plot.title = element_text(face="bold", size=13, hjust = 0.5)) +
  theme(plot.subtitle = element_text(size = 10, hjust = 0.5, face = "italic")) +
  theme(plot.caption = element_text(size = 8, hjust = 0.0, face = "italic")) +
  theme(axis.title = element_text(size = 16)) +
  theme(axis.text.x = element_text(size = 14, color = "Black")) +
  theme(axis.text.y = element_text(size = 14, color = "Black")) 


tiff("../plots/d_EvReg_i_HHEnjoy.tiff",       
      res = 300,
      units = "in",
      width = 6, 
      height = 4.5)
plot
dev.off()
