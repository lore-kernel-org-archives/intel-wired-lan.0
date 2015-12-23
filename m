From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 23 Dec 2015 08:53:44 -0800
Subject: [Intel-wired-lan] [PATCH next] ixgbe: Fix misuse of word as
 register offset instead of offset in register array
In-Reply-To: <20151223164640.30102.45304.stgit@localhost.localdomain>
References: <20151223164640.30102.45304.stgit@localhost.localdomain>
Message-ID: <CAKgT0UfXqEPobd_WJzSkf2xLiqxjbq0wmb=9rEqaNm_9j5ZuZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Dec 23, 2015 at 8:47 AM, Alexander Duyck <aduyck@mirantis.com> wrote:
> When I had rewritten the code for ixgbe_clear_vf_vlans() it looks like I
> had transitioned back and forth between using word as an offset and using
> word as a register offset.  As a result I honestly don't see how the code
> was working before other than the fact that resetting the VLANs on the VF
> like didn't do much to clear them.
>
> I have updated the code so that word represents the offset in the array.
> This way we can use the modulus and xor operations and they will make sense
> instead of being performed on a 4 byte aligned value.
>
> I replaced the statement "(word % 2) ^ 1" with "~word % 2" in order to
> reduce the line length as the line exceeded 80 characters with the register
> name inserted.  The two should be equivalent so the change should be safe.
>
> Reported-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index eeff3d075bf8..009ba2e21687 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> @@ -593,11 +593,11 @@ static void ixgbe_clear_vf_vlans(struct ixgbe_adapter *adapter, u32 vf)
>
>         /* post increment loop, covers VLVF_ENTRIES - 1 to 0 */
>         for (i = IXGBE_VLVF_ENTRIES; i--;) {
> -               u32 word = IXGBE_VLVFB(i * 2 + vf / 32);
>                 u32 bits[2], vlvfb, vid, vfta, vlvf;
> +               u32 word = i * 2 + vf / 32;
>                 u32 mask = 1 << (vf / 32);

I'll need to submit a v2 for this.  It turns out the mask is wrong as
well.  That should be a % 32, not a / 32 used.

> -               vlvfb = IXGBE_READ_REG(hw, word);
> +               vlvfb = IXGBE_READ_REG(hw, IXGBE_VLVFB(word));
>
>                 /* if our bit isn't set we can skip it */
>                 if (!(vlvfb & mask))
> @@ -608,7 +608,7 @@ static void ixgbe_clear_vf_vlans(struct ixgbe_adapter *adapter, u32 vf)
>
>                 /* create 64b mask to chedk to see if we should clear VLVF */
>                 bits[word % 2] = vlvfb;
> -               bits[(word % 2) ^ 1] = IXGBE_READ_REG(hw, word ^ 1);
> +               bits[~word % 2] = IXGBE_READ_REG(hw, IXGBE_VLVFB(word ^ 1));
>
>                 /* if promisc is enabled, PF will be present, leave VFTA */
>                 if (adapter->flags2 & IXGBE_FLAG2_VLAN_PROMISC) {
>
