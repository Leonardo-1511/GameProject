extends EntityResource
class_name CharacterResource

enum characterClass {MEDIUM, HEAVY, LIGHT}

@export var character_class: characterClass ## Class for the Character. This will change their Speed and limit the Choice on Weaponry
@export var mana_level: int ## Level for ManaPower, changes with Spells usage. Limits Spells and the Force/Damage.
@export var character_level: int ## Level for Character. This will limit weaponry and changes the Physical Damage.
