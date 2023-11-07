+++
title = '[OUTDATED/ARCHIVED] Unreal Multiplayer Server Research'
date = 2023-11-06T21:22:49-06:00
draft = true
type = "post"
tags = ["Archive"]
+++

Unreal Engine Development Page
Posting stuff related to unreal engine development




Server Replication Notes



When testing rapid fire projectiles replicated on a multiplayer server, we discovered that high speed settings like 50,000 would cause errors on client replication. The errors would make it so the projectile impacts would not replicate at a specific proximity to the character even though the hit detection was still validating that the projectile was being handled. Still unsure whats causing this, however it's easily fixed by using a more reasonable speed like 5,000.




Replication through blueprints



You can replicate any of your blueprint functions by calling them from a "Custom Event" that is set to "Call on Server". If the function needs to be cast to every single player, you can cast the custom event to another custom event that will "Multicast" the replication call.


After creating the custom events they will be referenceable from your blueprint, set your Call on Server custom event into your reference for Multicasting, then put your multicast custom event into the function it needs to replicate


You should also cast into your call on server reference from whatever input causes your replicated function, you can connect this initialization into the final result of the function if it is something like look rotation that will be constantly replicated. You do not want constantly replicated events to be handled exclusively through the network. This could cause something like view rotation to become choppy because it will only be updated as fast as its server latency. In this case, its worth noting the "reliable" button on your custom event should be OFF if the event is going to be called frequently.


Events that do not happen as frequently but must be replicated losslessly should be marked as "reliable" when setting up their custom replication events


Individual variables like floats and booleans can also be replicated(and usually essentially need to be) through an option on the blueprint titled replication. You can set it to replicated or repNotify. When set to replicated the variable will allow input from the server to influence changes in the networked game, when set to repNotify the Client and Server will experience the same instance of events that are performed on any of the connected clients

