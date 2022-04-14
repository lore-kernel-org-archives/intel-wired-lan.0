From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 14 Apr 2022 12:16:17 +0000
Subject: [Intel-wired-lan] [PATCH v2] ice: wait 5 s for EMP reset after
 firmware flash
In-Reply-To: <20220413153745.1125674-1-poros@redhat.com>
References: <20220412102753.670867-1-poros@redhat.com>
 <20220413153745.1125674-1-poros@redhat.com>
Message-ID: <BYAPR11MB33671AA8F5947FEFB6FAA9F1FCEF9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Petr Oros
> Sent: Wednesday, April 13, 2022 9:08 PM
> To: netdev at vger.kernel.org
> Cc: ivecera <ivecera@redhat.com>; pmenzel at molgen.mpg.de; intel-wired-
> lan at lists.osuosl.org; linux-kernel at vger.kernel.org; kuba at kernel.org;
> pabeni at redhat.com; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH v2] ice: wait 5 s for EMP reset after
> firmware flash
> 
> We need to wait 5 s for EMP reset after firmware flash. Code was extracted
> from OOT driver (ice v1.8.3 downloaded from sourceforge). Without this
> wait, fw_activate let card in inconsistent state and recoverable only by
> second flash/activate. Flash was tested on these fw's:
> From -> To
>  3.00 -> 3.10/3.20
>  3.10 -> 3.00/3.20
>  3.20 -> 3.00/3.10
> 
> Reproducer:
> [root at host ~]# devlink dev flash pci/0000:ca:00.0 file
> E810_XXVDA4_FH_O_SEC_FW_1p6p1p9_NVM_3p10_PLDMoMCTP_0.11_80
> 00AD7B.bin
> Preparing to flash
> [fw.mgmt] Erasing
> [fw.mgmt] Erasing done
> [fw.mgmt] Flashing 100%
> [fw.mgmt] Flashing done 100%
> [fw.undi] Erasing
> [fw.undi] Erasing done
> [fw.undi] Flashing 100%
> [fw.undi] Flashing done 100%
> [fw.netlist] Erasing
> [fw.netlist] Erasing done
> [fw.netlist] Flashing 100%
> [fw.netlist] Flashing done 100%
> Activate new firmware by devlink reload
> [root at host ~]# devlink dev reload pci/0000:ca:00.0 action fw_activate
> reload_actions_performed:
>     fw_activate
> [root at host ~]# ip link show ens7f0
> 71: ens7f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq
> state DOWN mode DEFAULT group default qlen 1000
>     link/ether b4:96:91:dc:72:e0 brd ff:ff:ff:ff:ff:ff
>     altname enp202s0f0
> 
> dmesg after flash:
> [   55.120788] ice: Copyright (c) 2018, Intel Corporation.
> [   55.274734] ice 0000:ca:00.0: Get PHY capabilities failed status = -5,
> continuing anyway
> [   55.569797] ice 0000:ca:00.0: The DDP package was successfully loaded: ICE
> OS Default Package version 1.3.28.0
> [   55.603629] ice 0000:ca:00.0: Get PHY capability failed.
> [   55.608951] ice 0000:ca:00.0: ice_init_nvm_phy_type failed: -5
> [   55.647348] ice 0000:ca:00.0: PTP init successful
> [   55.675536] ice 0000:ca:00.0: DCB is enabled in the hardware, max number
> of TCs supported on this port are 8
> [   55.685365] ice 0000:ca:00.0: FW LLDP is disabled, DCBx/LLDP in SW mode.
> [   55.692179] ice 0000:ca:00.0: Commit DCB Configuration to the hardware
> [   55.701382] ice 0000:ca:00.0: 126.024 Gb/s available PCIe bandwidth, limited
> by 16.0 GT/s PCIe x8 link at 0000:c9:02.0 (capable of 252.048 Gb/s with 16.0
> GT/s PCIe x16 link)
> Reboot doesn?t help, only second flash/activate with OOT or patched driver
> put card back in consistent state.
> 
> After patch:
> [root at host ~]# devlink dev flash pci/0000:ca:00.0 file
> E810_XXVDA4_FH_O_SEC_FW_1p6p1p9_NVM_3p10_PLDMoMCTP_0.11_80
> 00AD7B.bin
> Preparing to flash
> [fw.mgmt] Erasing
> [fw.mgmt] Erasing done
> [fw.mgmt] Flashing 100%
> [fw.mgmt] Flashing done 100%
> [fw.undi] Erasing
> [fw.undi] Erasing done
> [fw.undi] Flashing 100%
> [fw.undi] Flashing done 100%
> [fw.netlist] Erasing
> [fw.netlist] Erasing done
> [fw.netlist] Flashing 100%
> [fw.netlist] Flashing done 100%
> Activate new firmware by devlink reload
> [root at host ~]# devlink dev reload pci/0000:ca:00.0 action fw_activate
> reload_actions_performed:
>     fw_activate
> [root at host ~]# ip link show ens7f0
> 19: ens7f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
> state UP mode DEFAULT group default qlen 1000
>     link/ether b4:96:91:dc:72:e0 brd ff:ff:ff:ff:ff:ff
>     altname enp202s0f0
> 
> v2 changes:
> - fixed format issues
> - added info about fw and OOT driver versions
> - added time in the commit message summary
> - appended the unit to the macro name
> 
> Fixes: 399e27dbbd9e94 ("ice: support immediate firmware activation via
> devlink reload")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
