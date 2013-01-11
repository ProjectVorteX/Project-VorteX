-- modify tables to allow higher phases

ALTER TABLE `corpse`
MODIFY COLUMN `phaseMask`  int(10) UNSIGNED NOT NULL DEFAULT 1;