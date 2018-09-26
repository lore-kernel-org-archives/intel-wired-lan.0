From: Venkataramanan, Anirudh <anirudh.venkataramanan@intel.com>
Date: Wed, 26 Sep 2018 22:57:33 +0000
Subject: [Intel-wired-lan] [PATCH v2 06/16] ice: Add handlers for VF
 netdevice operations
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC825@ORSMSX106.amr.corp.intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
 <20180920004308.13772-7-anirudh.venkataramanan@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC825@ORSMSX106.amr.corp.intel.com>
Message-ID: <1538002651.5258.60.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-09-26 at 14:41 -0700, Bowers, AndrewX wrote:
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org]
> > On
> > Behalf Of Anirudh Venkataramanan
> > Sent: Wednesday, September 19, 2018 5:43 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [PATCH v2 06/16] ice: Add handlers for
> > VF
> > netdevice operations
> > 
> > This patch implements handlers for the following NDO operations:
> > 
> > .ndo_set_vf_spoofchk
> > .ndo_set_vf_mac
> > .ndo_get_vf_config
> > .ndo_set_vf_trust
> > .ndo_set_vf_vlan
> > .ndo_set_vf_link_state
> > 
> > Signed-off-by: Anirudh Venkataramanan
> > <anirudh.venkataramanan@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h   |  12 +
> >  drivers/net/ethernet/intel/ice/ice_main.c        |   6 +
> >  drivers/net/ethernet/intel/ice/ice_sriov.c       |  86 +++++
> >  drivers/net/ethernet/intel/ice/ice_sriov.h       |   9 +
> >  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 438
> > +++++++++++++++++++++++
> > drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  79 +++-
> >  6 files changed, 629 insertions(+), 1 deletion(-)
> 
> 
> Not sure why this did not manifest itself on my Simics system during
> build, but on my link partner doing a compile test I get an error
> during build, looks like the kbuild test robot picked it up as well
> - 
> 
> "drivers/net/ethernet/intel/ice/ice_main.c:3944:25: error:
> 'ice_netpoll" undeclared here (not in a function); did you mean
> 'ice_napi_poll?"
>   .ndo_poll_controller = ice_netpoll

Upstream commit 158a08a694c4 ("ice: remove ndo_poll_controller")
removed ice_netpoll(). When this patch is applied as is, it seems to
add the line ".ndo_poll_controller = ice_netpoll" back, which is
incorrect.

Spoke to Jeff about this. He said he'll make a change to resolve this
in his tree.

> 
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3302 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180926/61f829ae/attachment-0001.bin>
