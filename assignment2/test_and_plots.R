require(tidyverse)


# Entrenamiento offline

hoeffding_offline <- scan("hoeffding_offline.txt")
hoeffding_adaptativo_offline <- scan("hoeffding_adaptativo_offline.txt")

offline <- data.frame(
    "Hoeffding"=hoeffding_offline,
    "Hoeffding adaptativo"=hoeffding_adaptativo_offline,
    check.names = F
)

wilcox.test(
    offline$Hoeffding,
    offline$`Hoeffding adaptativo`,
    alternative = "two.sided",
    paired = TRUE
)

median(offline$Hoeffding)
median(offline$`Hoeffding adaptativo`)

offline %>% gather(
    "Variables",
    "Values"
) %>% ggplot(
    .,
    aes(y=Values)
) + geom_boxplot() + facet_wrap(
    ~ Variables
) + labs(
    title="Entrenamiento offline (estacionario) y evaluación posterior",
    y="Porcentaje de acierto"
)


# Entrenamiento online

hoeffding_online <- scan("hoeffding_online.txt")
hoeffding_adaptativo_online <- scan("hoeffding_adaptativo_online.txt")

online <- data.frame(
    "Hoeffding"=hoeffding_online,
    "Hoeffding adaptativo"=hoeffding_adaptativo_online,
    check.names = F
)

wilcox.test(
    online$Hoeffding,
    online$`Hoeffding adaptativo`,
    alternative = "two.sided",
    paired = TRUE
)

median(online$Hoeffding)
median(online$`Hoeffding adaptativo`)


online %>% gather(
    "Variables",
    "Values"
) %>% ggplot(
    .,
    aes(y=Values)
) + geom_boxplot() + facet_wrap(
    ~ Variables
) + labs(
    title="Entrenamiento online",
    y="Porcentaje de acierto"
)


####################
# ONLINE CON DRIFT

hoeffding_online_drift <- scan("hoeffding_online_drift.txt")
hoeffding_adaptativo_online_drift <- scan("hoeffding_adaptativo_online_drift.txt")

online_drift <- data.frame(
    "Hoeffding"=hoeffding_online_drift,
    "Hoeffding adaptativo"=hoeffding_adaptativo_online_drift,
    check.names = F
)

wilcox.test(
    online_drift$Hoeffding,
    online_drift$`Hoeffding adaptativo`,
    alternative = "two.sided",
    paired = TRUE
)

median(online_drift$Hoeffding)
median(online_drift$`Hoeffding adaptativo`)

online_drift %>% gather(
    "Variables",
    "Values"
) %>% ggplot(
    .,
    aes(y=Values)
) + geom_boxplot() + facet_wrap(
    ~ Variables
) + labs(
    title="Entrenamiento online en datos con concept drift",
    y="Porcentaje de acierto"
)


## Prequential

prequential_hoeffding_online_drift <- scan("prequential_hoeffding_online_drift.txt")
prequential_hoeffding_adaptativo_online_drift <- scan("prequential_hoeffding_adaptativo_online_drift.txt")

hoeffding.NoPrequentialVsPrequential <- data.frame(
    "Hoeffding sin prequential"=hoeffding_online_drift,
    "Hoeffding con prequential"=prequential_hoeffding_online_drift,
    check.names = F
)

hoeffding.adaptativo.NoPrequentialVsPrequential <- data.frame(
    "Hoeffding adaptativo sin prequential"=hoeffding_adaptativo_online_drift,
    "Hoeffding adaptativo con prequential"=prequential_hoeffding_adaptativo_online_drift,
    check.names = F
)

wilcox.test(
    hoeffding.NoPrequentialVsPrequential$`Hoeffding sin prequential`,
    hoeffding.NoPrequentialVsPrequential$`Hoeffding con prequential`,
    alternative = "two.sided",
    paired = TRUE
)

wilcox.test(
    hoeffding.adaptativo.NoPrequentialVsPrequential$`Hoeffding adaptativo sin prequential`,
    hoeffding.adaptativo.NoPrequentialVsPrequential$`Hoeffding adaptativo con prequential`,
    alternative = "two.sided",
    paired = TRUE
)

hoeffding.NoPrequentialVsPrequential %>% gather(
    "Variables",
    "Values"
) %>% ggplot(
    .,
    aes(y=Values)
) + geom_boxplot() + facet_wrap(
    ~ Variables
) + labs(
    title="Hoeffding Con prequential vs Sin prequential",
    y="Porcentaje de acierto"
)

hoeffding.adaptativo.NoPrequentialVsPrequential %>% gather(
    "Variables",
    "Values"
) %>% ggplot(
    .,
    aes(y=Values)
) + geom_boxplot() + facet_wrap(
    ~ Variables
) + labs(
    title="Hoeffding adaptativo Con prequential vs Sin prequential",
    y="Porcentaje de acierto"
)


## Single classifier drift

single_classifier_drift_hoeffding_online_drift <- scan("single_classifier_drift_hoeffding_online_drift.txt")
single_classifier_drift_hoeffding_adaptativo_online_drift <- scan("single_classifier_drift_hoeffding_adaptativo_online_drift.txt")

single_classifier_drift_online_drift <- data.frame(
    "Hoeffding"=single_classifier_drift_hoeffding_online_drift,
    "Hoeffding adaptativo"=single_classifier_drift_hoeffding_adaptativo_online_drift,
    check.names = F
)

diffs <- (single_classifier_drift_online_drift$Hoeffding - single_classifier_drift_online_drift$`Hoeffding adaptativo`) / single_classifier_drift_online_drift$Hoeffding
wilcoxon <- cbind(
    ifelse(
        diffs<0,
        abs(diffs)+0.1,
        0+0.1
    ),
    ifelse(
        diffs>0,
        abs(diffs)+0.1,
        0+0.1
    )
)

wilcox.test(
    wilcoxon[, 1],
    wilcoxon[, 2],
    alternative = "two.sided",
    paired = TRUE
)

single_classifier_drift_online_drift %>% gather(
    "Variables",
    "Values"
) %>% ggplot(
    .,
    aes(y=Values)
) + geom_boxplot() + facet_wrap(
    ~ Variables
) + labs(
    title="Entrenamiento online en datos con concept drift. Reinicialización",
    y="Porcentaje de acierto"
)
