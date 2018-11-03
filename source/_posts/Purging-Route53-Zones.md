title: Purging Route53 Zones
tags: aws
---

The setup and tear-down of Route53 hosted zones doesn't happen often. In order to delete a hosted zone all records except the NS and SOA records need to be deleted. This can be difficult if you have a zone with a few thousand records - common if you are [seeding your reverse and forward lookups](https://github.com/justmiles/route53_subnet_seeder). When you are sure a zone needs to purged, you can lean on the below script to purge all records from a hosted zone while saving a backup locally.

<!-- more -->

<script src="https://gist.github.com/justmiles/4ae3d3148001cbead6a4e3dee392a849.js"></script>
