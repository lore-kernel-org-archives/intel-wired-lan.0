From: Templeman, Chaim <chaim.templeman@intel.com>
Date: Mon, 13 Apr 2015 18:26:46 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Cleanup handling of VLAN_HLEN
 as a part of max frame size
In-Reply-To: <55269FF6.4090003@gmail.com>
References: <alpine.NEB.2.11.1504081019220.3388@chris.i8u.org>
 <20150408204630.4643.37880.stgit@ahduyck-vm-fedora22>
 <alpine.NEB.2.11.1504081413510.3388@chris.i8u.org>
 <5525B2AE.80301@gmail.com>
 <alpine.NEB.2.11.1504081602260.3388@chris.i8u.org>
 <5525B62A.1050601@gmail.com>
 <alpine.NEB.2.11.1504081705350.3388@chris.i8u.org>
 <alpine.NEB.2.11.1504081714400.3388@chris.i8u.org>
 <5525D389.3010700@gmail.com>
 <BD4006F19E8FC247A4760EC0EE12CCDF468ACD40@HASMSX110.ger.corp.intel.com>
 <55269FF6.4090003@gmail.com>
Message-ID: <BD4006F19E8FC247A4760EC0EE12CCDF468AE3D6@HASMSX110.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I checked with the HW guys, and they confirmed that a total packet size of 9022 is acceptable.
The original size of 9018 was defined as:
Frame size (9018) = DST (6) + SRC (6) + VLAN (4) + TYPE (2) + MTU (x) + CRC (4).
If an additional 4 bytes is required, that is ok.

-----Original Message-----
From: Alexander Duyck [mailto:alexander.duyck at gmail.com] 
Sent: Thursday, April 09, 2015 18:51
To: Templeman, Chaim; Hisashi T Fujinaka
Cc: netdev at vger.kernel.org; mike at cchtml.com; intel-wired-lan at lists.osuosl.org; Ertman, David M; Lubetkin, YanirX
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Cleanup handling of VLAN_HLEN as a part of max frame size

On 04/08/2015 11:17 PM, Templeman, Chaim wrote:
> We will look into this with the HW architect and get back to you on what the HW limitations actually are on this issue.

Chaim, thanks for looking into this.  The key piece that would be useful
to know is if the 9018 should really be 9022 if you account for both
VLAN header and CRC.  Based on the documentation for the Windows driver
that seems to be the case as they support an MTU of 9014 excluding the 8
bytes for CRC and VLAN header.

- Alex
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

