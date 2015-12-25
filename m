From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Fri, 25 Dec 2015 15:57:40 +0000
Subject: [Intel-wired-lan] [next PATCH v2] ixgbe: Fix bugs in
	ixgbe_clear_vf_vlans()
In-Reply-To: <20151223165946.30452.68020.stgit@localhost.localdomain>
References: <20151223165946.30452.68020.stgit@localhost.localdomain>
Message-ID: <87618083B2453E4A8714035B62D67992504F4017@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Alexander Duyck [mailto:aduyck at mirantis.com]
>Sent: Wednesday, December 23, 2015 9:01 AM
To: intel-wired-lan@lists.osuosl.org; alexander.duyck at gmail.com
>Cc: Tantilov, Emil S; Kirsher, Jeffrey T
>Subject: [next PATCH v2] ixgbe: Fix bugs in ixgbe_clear_vf_vlans()
>
>When I had rewritten the code for ixgbe_clear_vf_vlans() it looks like I
>had transitioned back and forth between using word as an offset and using
>word as a register offset.  As a result I honestly don't see how the code
>was working before other than the fact that resetting the VLANs on the VF
>like didn't do much to clear them.
>
>Another issue found is that the mask was using a divide instead of a
>modulus.  As a result the mask bit was incorrectly being set to either bit
>0 or 1 based on the value of the VF being tested.  As a result the wrong
>VFs were having their VLANs cleared if they were enabled.
>
>I have updated the code so that word represents the offset in the array.
>This way we can use the modulus and xor operations and they will make sense
>instead of being performed on a 4 byte aligned value.
>
>I replaced the statement "(word % 2) ^ 1" with "~word % 2" in order to
>reduce the line length as the line exceeded 80 characters with the register
>name inserted.  The two should be equivilent so the change should be safe.
>
>Reported-by: Emil Tantilov <emil.s.tantilov@intel.com>
>Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>---
>
>v2: Fixed incorrect configuration for mask that used division instead of
>    modulus.
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
>b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
>index eeff3d075bf8..8025a3f93598 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
>@@ -593,11 +593,11 @@ static void ixgbe_clear_vf_vlans(struct ixgbe_adapter
>*adapter, u32 vf)
>
> 	/* post increment loop, covers VLVF_ENTRIES - 1 to 0 */
> 	for (i = IXGBE_VLVF_ENTRIES; i--;) {
>-		u32 word = IXGBE_VLVFB(i * 2 + vf / 32);
> 		u32 bits[2], vlvfb, vid, vfta, vlvf;
>-		u32 mask = 1 << (vf / 32);
>+		u32 word = i * 2 + vf / 32;
>+		u32 mask = 1 << (vf % 32);
>
>-		vlvfb = IXGBE_READ_REG(hw, word);
>+		vlvfb = IXGBE_READ_REG(hw, IXGBE_VLVFB(word));
>
> 		/* if our bit isn't set we can skip it */
> 		if (!(vlvfb & mask))
>@@ -608,7 +608,7 @@ static void ixgbe_clear_vf_vlans(struct ixgbe_adapter
>*adapter, u32 vf)
>
> 		/* create 64b mask to chedk to see if we should clear VLVF */
> 		bits[word % 2] = vlvfb;
>-		bits[(word % 2) ^ 1] = IXGBE_READ_REG(hw, word ^ 1);
>+		bits[~word % 2] = IXGBE_READ_REG(hw, IXGBE_VLVFB(word ^ 1));
>
> 		/* if promisc is enabled, PF will be present, leave VFTA */
> 		if (adapter->flags2 & IXGBE_FLAG2_VLAN_PROMISC) {

This looks good. Thanks Alex!

Acked-by: Emil Tantilov <emil.s.tantilov@intel.com>


