From: Ruinskiy, Dima <dima.ruinskiy@intel.com>
Date: Tue, 5 Apr 2016 13:41:19 +0000
Subject: [Intel-wired-lan] [PATCH-RFC] drivers: net: ethernet: intel:
 e1000e: fix ethtool autoneg off for fiber
In-Reply-To: <5702F2D6.5010105@cisco.com>
References: <1458943126-32258-1-git-send-email-danielwa@cisco.com>
 <56FC2A62.6040206@cisco.com>
 <36CDDD56DDB4D44E911123902EFC26B05B440F17@HASMSX110.ger.corp.intel.com>
 <5702F2D6.5010105@cisco.com>
Message-ID: <36CDDD56DDB4D44E911123902EFC26B05B4413D1@HASMSX110.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sure, please send. It will be reviewed like any other patch. :)

-----Original Message-----
From: Daniel Walker [mailto:danielwa at cisco.com] 
Sent: Tuesday, April 05, 2016 02:04
To: Ruinskiy, Dima; Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald C; Allan, Bruce W; Ronciak, John; Williams, Mitch A
Cc: netdev at vger.kernel.org; xe-kernel at external.cisco.com; danielwa at fifo99.com; linux-kernel at vger.kernel.org; Steve Shih; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH-RFC] drivers: net: ethernet: intel: e1000e: fix ethtool autoneg off for fiber

On 04/03/2016 07:23 AM, Ruinskiy, Dima wrote:
> I have a couple of comments (sorry for not getting to it a bit sooner).
>
>> For fiber media, e1000_get_settings should return ETH_TP_MDI_INVALID for
>> eth_tp_mdix_ctrl instead of ETH_TP_MDI_AUTO so subsequent e1000_set_settings
>> call would not fail with -EOPNOTSUPP.
> Should this be specific to fiber? Because the code just checks media != copper. There is at least other media type (e1000_media_type_internal_serdes), which will be affected by this change as well. What is the proper behavior in this case?
Steve is shy, so here are his comments,

<Steve>
Regarding the 1st comment. The issue affects all non-copper media. In 
fact, we are using e1000_media_type_internal_serdes and are affected due 
to the following check in e1000_set_settings:

/* MDI setting is only allowed when autoneg enabled because
* some hardware doesn't allow MDI setting when speed or
* duplex is forced.
*/
if (ecmd->eth_tp_mdix_ctrl) {
if (hw->phy.media_type != e1000_media_type_copper)
return -EOPNOTSUPP;

if ((ecmd->eth_tp_mdix_ctrl != ETH_TP_MDI_AUTO) &&
(ecmd->autoneg != AUTONEG_ENABLE)) {
e_err("forcing MDI/MDI-X state is not supported when link speed and/or 
duplex are forced\n");
return -EINVAL;
}
}

</Steve>

>> e1000_set_spd_dplx should not automatically turn autoneg back on for forced
>> 1000 Mbps full duplex settings.
> I seem to remember that this code is there because the copper-based NICs only support 1000Mbps in auto-negotiation mode, not forced (this is according to the IEEE spec, as far as I know). I believe this code is there to ensure that a user can force the speed to 1000 via the API, and still have the link resolve correctly via auto-negotiation. I am concerned that changing this code will break clients that rely on it. Maybe it is best to also limit it to fiber devices only?
>

<Steve>
Regarding the 2nd comment. Yes, will limit to non-copper media.
</Steve>

He supplied me with a second patch which I can send.. Can we remove the 
RFC this time ?

Daniel
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

