require(tidyverse)


# Entrenamiento offline

hoeffding_offline <- scan("hoeffding_offline.txt")
hoeffding_adaptativo_offline <- scan("hoeffding_adaptativo_offline.txt")

offline <- data.frame(
    "Hoeffding"=hoeffding_offline,
    "Hoeffding adaptativo"=hoeffding_adaptativo_offline,
    check.names = F
)

# Normalización datos para evitar empates en wilcoxon

diffs <- (offline$Hoeffding - offline$`Hoeffding adaptativo`) / offline$Hoeffding
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

# Normalización datos para evitar empates en wilcoxon

diffs <- (online$Hoeffding - online$`Hoeffding adaptativo`) / online$Hoeffding
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

# Normalización datos para evitar empates en wilcoxon

diffs <- (online_drift$Hoeffding - online_drift$`Hoeffding adaptativo`) / online_drift$Hoeffding
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

prequential_online_drift <- data.frame(
    "Hoeffding"=prequential_hoeffding_online_drift,
    "Hoeffding adaptativo"=prequential_hoeffding_adaptativo_online_drift,
    check.names = F
)

diffs <- (prequential_online_drift$Hoeffding - prequential_online_drift$`Hoeffding adaptativo`) / prequential_online_drift$Hoeffding
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

prequential_online_drift %>% gather(
    "Variables",
    "Values"
) %>% ggplot(
    .,
    aes(y=Values)
) + geom_boxplot() + facet_wrap(
    ~ Variables
) + labs(
    title="Entrenamiento online en datos con concept drift. Olvido de instancias",
    y="Porcentaje de acierto"
)


## Prequential

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
