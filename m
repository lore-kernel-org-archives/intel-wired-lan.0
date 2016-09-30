From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 30 Sep 2016 00:03:23 -0700
Subject: [Intel-wired-lan] [next PATCH S49 01/15] i40e: drop is_vf and
 is_netdev fields in struct i40e_mac_filter
In-Reply-To: <1475169095-20873-2-git-send-email-bimmy.pujari@intel.com>
References: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
 <1475169095-20873-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475219003.2320.38.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-09-29 at 10:11 -0700, Bimmy Pujari wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Originally the is_vf and is_netdev fields were added in order to
> distinguish between VF and netdev filters in a single VSI. However, it
> can be noted that we use separate VSI for SRIOV VFs and for netdev VSI.
> Thus, since a single VSI should only ever have one type of filter, we
> can simply remove the checks and remove the typing.
> 
> In a similar fashion, we can note that the only remaining way to get
> multiple filters of a single type is through a debug command that was
> added to debugfs. This command is useless in practice, and results in
> causing bugs if we keep counter tracking but lose the is_vf and
> is_netdev protections as desired above.
> 
> Since the only time we'd actually have a counter value besides 0 and
> 1 is through use of this debugfs hook, we can remove this unnecessary
> command, and the entire counter logic it required.
> 
> We vastly simplify mac filters by removing
> 
> (a) the distinction between vf and netdev filters
> (b) counting logic
> (c) the ability to add and remove filters bypassing the stack via debugfs
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Idf916dd2a1159b1188ddbab5bef6b85ea6bf27d9

Does not compile, here are the errors:

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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160930/f6f17b56/attachment.asc>
