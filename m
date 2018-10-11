From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 11 Oct 2018 17:41:22 +0000
Subject: [Intel-wired-lan] [PATCH v2 08/12] Documentation: i40e: Prepare
 documentation for RST conversion
In-Reply-To: <3e65b77a-67af-eff5-7296-654038634a00@oracle.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
 <20181010191613.2770-9-jeffrey.t.kirsher@intel.com>
 <3e65b77a-67af-eff5-7296-654038634a00@oracle.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884CD2AD2@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Shannon Nelson
> Sent: Thursday, October 11, 2018 9:41 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v2 08/12] Documentation: i40e: Prepare
> documentation for RST conversion
> 
> On 10/10/2018 12:16 PM, Jeff Kirsher wrote:
> > Before making the conversion to the rst (reStructured Text) format, there
> > are changes needed to the documentation so that there are no build errors.
> >
> > Also fixed old/broken URLs to the correct or updated URL.
> >
> > Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > ---
> >   Documentation/networking/i40e.txt | 837 +++++++++++++++++++++++++-----
> >   1 file changed, 714 insertions(+), 123 deletions(-)
> >
> > diff --git a/Documentation/networking/i40e.txt
> b/Documentation/networking/i40e.txt
> > index c2d6e1824b29..f0c3c8c9d324 100644
> > --- a/Documentation/networking/i40e.txt
> > +++ b/Documentation/networking/i40e.txt
> > @@ -1,190 +1,781 @@
> > -Linux Base Driver for the Intel(R) Ethernet Controller XL710 Family
> > -===================================================================
> > +.. SPDX-License-Identifier: GPL-2.0+
> >
> > -Intel i40e Linux driver.
> > -Copyright(c) 2013 Intel Corporation.
> > +Linux* Base Driver for the Intel(R) Ethernet Controller 700 Series
> > +==================================================================
> > +
> > +Intel 40 Gigabit Linux driver.
> > +Copyright(c) 1999-2018 Intel Corporation.
> >
> >   Contents
> >   ========
> >
> > +- Overview
> >   - Identifying Your Adapter
> > +- Intel(R) Ethernet Flow Director
> >   - Additional Configurations
> > -- Performance Tuning
> >   - Known Issues
> >   - Support
> >
> >
> > +Driver information can be obtained using ethtool, lspci, and ifconfig.
> > +Instructions on updating ethtool can be found in the section Additional
> > +Configurations later in this document.
> > +
> > +For questions related to hardware requirements, refer to the documentation
> > +supplied with your Intel adapter. All hardware requirements listed apply to use
> > +with Linux.
> > +
> > +
> >   Identifying Your Adapter
> >   ========================
> > +The driver is compatible with devices based on the following:
> > +
> > + * Intel(R) Ethernet Controller X710
> > + * Intel(R) Ethernet Controller XL710
> > + * Intel(R) Ethernet Network Connection X722
> > + * Intel(R) Ethernet Controller XXV710
> > +
> > +For the best performance, make sure the latest NVM/FW is installed on your
> > +device.
> > +
> > +For information on how to identify your adapter, and for the latest NVM/FW
> > +images and Intel network drivers, refer to the Intel Support website:
> > +https://www.intel.com/support
> > +
> > +SFP+ and QSFP+ Devices
> > +----------------------
> > +For information about supported media, refer to this document:
> > +https://www.intel.com/content/dam/www/public/us/en/documents/release-
> notes/xl710-ethernet-controller-feature-matrix.pdf
> > +
> > +NOTE: Some adapters based on the Intel(R) Ethernet Controller 700 Series only
> > +support Intel Ethernet Optics modules. On these adapters, other modules are not
> > +supported and will not function.  In all cases Intel recommends using Intel
> > +Ethernet Optics; other modules may function but are not validated by Intel.
> > +Contact Intel for supported media types.
> > +
> > +NOTE: For connections based on Intel(R) Ethernet Controller 700 Series, support
> > +is dependent on your system board. Please see your vendor for details.
> > +
> > +NOTE: In systems that do not have adequate airflow to cool the adapter and
> > +optical modules, you must use high temperature optical modules.
> > +
> > +Virtual Functions (VFs)
> > +-----------------------
> > +Use sysfs to enable VFs. For example:
> > +#echo $num_vf_enabled > /sys/class/net/$dev/device/sriov_numvfs	#enable
> > +VFs
> > +#echo 0 > /sys/class/net/$dev/device/sriov_numvfs	#disable VFs
> > +
> > +For example, the following instructions will configure PF eth0 and the first VF
> > +on VLAN 10::
> > +
> > +  $ ip link set dev eth0 vf 0 vlan 10
> > +
> > +VLAN Tag Packet Steering
> > +------------------------
> > +Allows you to send all packets with a specific VLAN tag to a particular SR-IOV
> > +virtual function (VF). Further, this feature allows you to designate a
> > +particular VF as trusted, and allows that trusted VF to request selective
> > +promiscuous mode on the Physical Function (PF).
> > +
> > +To set a VF as trusted or untrusted, enter the following command in the
> > +Hypervisor::
> > +
> > +  # ip link set dev eth0 vf 1 trust [on|off]
> > +
> > +Once the VF is designated as trusted, use the following commands in the VM to
> > +set the VF to promiscuous mode.
> > +
> > +::
> > +
> > +  For promiscuous all:
> > +  #ip link set eth2 promisc on
> > +  Where eth2 is a VF interface in the VM
> > +
> > +  For promiscuous Multicast:
> > +  #ip link set eth2 allmulticast on
> > +  Where eth2 is a VF interface in the VM
> > +
> > +NOTE: By default, the ethtool priv-flag vf-true-promisc-support is set to
> > +"off",meaning that promiscuous mode for the VF will be limited. To set the
> > +promiscuous mode for the VF to true promiscuous and allow the VF to see all
> > +ingress traffic, use the following command::
> > +
> > +  #ethtool -set-priv-flags p261p1 vf-true-promisc-support on
> > +
> > +The vf-true-promisc-support priv-flag does not enable promiscuous mode; rather,
> > +it designates which type of promiscuous mode (limited or true) you will get
> > +when you enable promiscuous mode using the ip link commands above. Note that
> > +this is a global setting that affects the entire device. However,the
> > +vf-true-promisc-support priv-flag is only exposed to the first PF of the
> > +device. The PF remains in limited promiscuous mode (unless it is in MFP mode)
> > +regardless of the vf-true-promisc-support setting.
> > +
> > +Now add a VLAN interface on the VF interface::
> > +
> > +  #ip link add link eth2 name eth2.100 type vlan id 100
> > +
> > +Note that the order in which you set the VF to promiscuous mode and add the
> > +VLAN interface does not matter (you can do either first). The end result in
> > +this example is that the VF will get all traffic that is tagged with VLAN 100.
> > +
> > +Intel(R) Ethernet Flow Director
> > +-------------------------------
> > +The Intel Ethernet Flow Director performs the following tasks:
> > +
> > +- Directs receive packets according to their flows to different queues.
> > +- Enables tight control on routing a flow in the platform.
> > +- Matches flows and CPU cores for flow affinity.
> > +- Supports multiple parameters for flexible flow classification and load
> > +  balancing (in SFP mode only).
> > +
> > +NOTE: The Linux i40e driver supports the following flow types: IPv4, TCPv4, and
> > +UDPv4. For a given flow type, it supports valid combinations of IP addresses
> > +(source or destination) and UDP/TCP ports (source and destination). For
> > +example, you can supply only a source IP address, a source IP address and a
> > +destination port, or any combination of one or more of these four parameters.
> > +
> > +NOTE: The Linux i40e driver allows you to filter traffic based on a
> > +user-defined flexible two-byte pattern and offset by using the ethtool user-def
> > +and mask fields. Only L3 and L4 flow types are supported for user-defined
> > +flexible filters. For a given flow type, you must clear all Intel Ethernet Flow
> > +Director filters before changing the input set (for that flow type).
> > +
> > +To enable or disable the Intel Ethernet Flow Director::
> > +
> > +  # ethtool -K ethX ntuple <on|off>
> > +
> > +When disabling ntuple filters, all the user programmed filters are flushed from
> > +the driver cache and hardware. All needed filters must be re-added when ntuple
> > +is re-enabled.
> > +
> > +To add a filter that directs packet to queue 2, use -U or -N switch::
> > +
> > +  # ethtool -N ethX flow-type tcp4 src-ip 192.168.10.1 dst-ip \
> > +  192.168.10.2 src-port 2000 dst-port 2001 action 2 [loc 1]
> > +
> > +To set a filter using only the source and destination IP address::
> > +
> > +  # ethtool -N ethX flow-type tcp4 src-ip 192.168.10.1 dst-ip \
> > +  192.168.10.2 action 2 [loc 1]
> > +
> > +To set a filter based on a user defined pattern and offset::
> > +
> > +  # ethtool -N ethX flow-type tcp4 src-ip 192.168.10.1 dst-ip \
> > +  192.168.10.2 user-def 0xffffffff00000001 m 0x40 action 2 [loc 1]
> > +
> > +Where the value of the user-def field (0xffffffff00000001) is the pattern and
> > +"m" 0x40 is the offset.
> 
> Repeating earlier comments:
> 0xffffffff00000001 is certainly not a two-byte pattern.  Can you explain
> this a little better?  Is 0x0001 the two-byte pattern being set up here
> with all the 0xffffffff0000 being scaffolding?
> 

The documentation is incorrect /out of date. I'm working with Jeff on this.

> Also, has anyone tested this lately?  I haven't, but I'm not so sure
> this is what the code in i40e_parse_rx_flow_user_data() is doing.
> 
> Actually, the detail below in the Sideband section that talks about "...
> user-def 0x4FFFF ..." looks much more correct, so why is this stuff here?
> 

This is more accurate.

> > +The maximum offset is 64. The hardware will only read up to 64 bytes of data
> > +from the payload. The offset must be even because the flexible data is 2 bytes
> > +long and must be aligned to byte 0 of the packet payload.
> 
> Hmmm... does this actually mean the end of the pattern can't be beyond
> the 64 bytes?  If the user gives 64 as the offset, then the bytes
> searched for the pattern would be bytes 65 and 66.  Maybe the max offset
> should be 62?

As far as I remember, the offset can be up to 64, meaning bytes 65 and 66. This documentation is likely slightly incorrect here.

Thanks,
Jake
