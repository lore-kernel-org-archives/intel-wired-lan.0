From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 1 Feb 2017 18:21:23 +0000
Subject: [Intel-wired-lan] [next-queue v5 PATCH 6/7] i40e: Add support
 for	exposing VF port statistics via VFPR netdev on the host
In-Reply-To: <1485392057-3261-7-git-send-email-sridhar.samudrala@intel.com>
References: <1485392057-3261-1-git-send-email-sridhar.samudrala@intel.com>
 <1485392057-3261-7-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857D66E8B@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Wednesday, January 25, 2017 4:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v5 PATCH 6/7] i40e: Add support for
> exposing VF port statistics via VFPR netdev on the host
> 

Hi,

I'm not sure which patch in the series causes this, but at least some of the changes cause sparse warnings when run with make C=1:


i40e/i40e_txrx.c:1410:22: error: incorrect type in initializer (different address spaces)
i40e/i40e_txrx.c:1410:22:    expected void const [noderef] <asn:3>*__vpp_verify
i40e/i40e_txrx.c:1410:22:    got struct vfpr_pcpu_stats *<noident>
i40e/i40e_txrx.c:3579:30: error: incorrect type in initializer (different address spaces)
i40e/i40e_txrx.c:3579:30:    expected void const [noderef] <asn:3>*__vpp_verify
i40e/i40e_txrx.c:3579:30:    got struct vfpr_pcpu_stats *<noident>
i40e/i40e_txrx.c:3585:17: error: incorrect type in initializer (different address spaces)
i40e/i40e_txrx.c:3585:17:    expected void const [noderef] <asn:3>*__vpp_verify
i40e/i40e_txrx.c:3585:17:    got unsigned long long *<noident>

Thanks,
Jake
