From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 30 Sep 2016 00:02:35 -0700
Subject: [Intel-wired-lan] [next PATCH S49 00/15] i40e/i40evf updates
In-Reply-To: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
References: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475218955.2320.37.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-09-29 at 10:11 -0700, Bimmy Pujari wrote:
> Alan Brady adds code to fix mac filters when removing vlans.
> 
> Jacob Keller drops is_vf and is_netdev fields in struct?
> i40e_mac_filter, adds code to make use of __dev_uc_sync?
> and __dev_mc_sync, moves i40e_put_mac_in_vlan and?
> i40e_del_mac_all_vlan, fixes i40e_put_mac_in_vlan to?
> return actual filter added, adds code to ignore removed?
> filters When searching all MAC/VLAN filters, implements?
> __i40e_del_filter and use where applicable, adds code to?
> store MAC/VLAN filters in a hash with the MAC Address as?
> key, adds code to properly cleanup on allocation failure?
> in i40e_sync_vsi_filters, adds code to avoid looping to?
> check whether we're in vlan mode, removes duplicate add/
> delete adminq command code for filters, corrects check?
> for reading TSYNINDX from the receive descriptor, uses a?
> mutex instead of spinlock in PTP user entry points, replaces?
> PTP Rx timestamp hang logic and adds code to avoid an extra?
> msleep while waiting for reset.
> 
> ?drivers/net/ethernet/intel/i40e/i40e.h?????????????|??50 +-
> ?drivers/net/ethernet/intel/i40e/i40e_debugfs.c?????|??92 +-
> ?drivers/net/ethernet/intel/i40e/i40e_main.c????????| 949 +++++++++++--
> --------
> ?drivers/net/ethernet/intel/i40e/i40e_ptp.c?????????| 137 +--
> ?drivers/net/ethernet/intel/i40e/i40e_txrx.c????????|???9 +-
> ?drivers/net/ethernet/intel/i40e/i40e_txrx.h????????|???2 -
> ?drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |??57 +-
> ?drivers/net/ethernet/intel/i40evf/i40evf_main.c????|???8 +-
> ?8 files changed, 663 insertions(+), 641 deletions(-)
> 

I tried to compile the very first patch it does not compile. ?I get the
following errors:

[23:59:15 @jtkirshe-linux:next-queue]$ make -j 77 -s
? DESCEND??objtool
drivers/net/ethernet/intel/i40e/i40e_fcoe.c: In function
?i40e_fcoe_config_netdev?:
drivers/net/ethernet/intel/i40e/i40e_fcoe.c:1526:2: error: too many
arguments to function ?i40e_add_filter?
? i40e_add_filter(vsi, hw->mac.san_addr, 0, false, false);
? ^~~~~~~~~~~~~~~
In file included from drivers/net/ethernet/intel/i40e/i40e_fcoe.c:37:0:
drivers/net/ethernet/intel/i40e/i40e.h:722:25: note: declared here
?struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
?????????????????????????^~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_fcoe.c:1527:2: error: too many
arguments to function ?i40e_add_filter?
? i40e_add_filter(vsi, (u8[6]) FC_FCOE_FLOGI_MAC, 0, false, false);
? ^~~~~~~~~~~~~~~
In file included from drivers/net/ethernet/intel/i40e/i40e_fcoe.c:37:0:
drivers/net/ethernet/intel/i40e/i40e.h:722:25: note: declared here
?struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
?????????????????????????^~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_fcoe.c:1528:2: error: too many
arguments to function ?i40e_add_filter?
? i40e_add_filter(vsi, FIP_ALL_FCOE_MACS, 0, false, false);
? ^~~~~~~~~~~~~~~
In file included from drivers/net/ethernet/intel/i40e/i40e_fcoe.c:37:0:
drivers/net/ethernet/intel/i40e/i40e.h:722:25: note: declared here
?struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
?????????????????????????^~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_fcoe.c:1529:2: error: too many
arguments to function ?i40e_add_filter?
? i40e_add_filter(vsi, FIP_ALL_ENODE_MACS, 0, false, false);
? ^~~~~~~~~~~~~~~
In file included from drivers/net/ethernet/intel/i40e/i40e_fcoe.c:37:0:
drivers/net/ethernet/intel/i40e/i40e.h:722:25: note: declared here
?struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
?????????????????????????^~~~~~~~~~~~~~~
scripts/Makefile.build:289: recipe for target
'drivers/net/ethernet/intel/i40e/i40e_fcoe.o' failed
make[5]: *** [drivers/net/ethernet/intel/i40e/i40e_fcoe.o] Error 1
make[5]: *** Waiting for unfinished jobs....
scripts/Makefile.build:440: recipe for target
'drivers/net/ethernet/intel/i40e' failed
make[4]: *** [drivers/net/ethernet/intel/i40e] Error 2
scripts/Makefile.build:440: recipe for target 'drivers/net/ethernet/intel'
failed
make[3]: *** [drivers/net/ethernet/intel] Error 2
scripts/Makefile.build:440: recipe for target 'drivers/net/ethernet' failed
make[2]: *** [drivers/net/ethernet] Error 2
scripts/Makefile.build:440: recipe for target 'drivers/net' failed
make[1]: *** [drivers/net] Error 2
Makefile:968: recipe for target 'drivers' failed
make: *** [drivers] Error 2

So I am dropping this series. ?Make sure every patch compiles on its own,
once you fix the first patch (and any other patches that may need changes),
please resubmit the series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160930/b46f98c1/attachment.asc>
