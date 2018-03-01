From: poza@codeaurora.org <poza@codeaurora.org>
Date: Thu, 01 Mar 2018 21:42:35 +0530
Subject: [Intel-wired-lan] SRIOV on Intel x710 fail to get attached both
 at VM creation time and VM runtime
In-Reply-To: <39dcd27f99192edd77baf4e418443edd@codeaurora.org>
References: <39dcd27f99192edd77baf4e418443edd@codeaurora.org>
Message-ID: <2a249cb55b6520cf2a25fbb5903ea56d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

+ intel-wired-lan at lists.osuosl.org

On 2018-03-01 21:41, poza at codeaurora.org wrote:
> Hi All,
> 
> I am facing the following issue on kernel 4.14.14.
> 
> Enable SRIOV on Intel x710 card.
> echo 32 > /sys/class/net/eth1/device/sriov_numvfs
> start net_pool
> virsh net-start intel_pool
> 
> case 1)
> attach the VF while creatig VM:
> virt-install --accelerate --import --disk /home/disk.img --network
> network=intel_pool  --boot uefi --name poza-guest --os-type linux
> --os-variant rhel7 --ram 8000 --vcpus 4
> 
> case 2)
> create VM:
> virt-install --accelerate --import --disk /home/disk.img --boot uefi
> --name poza-guest --os-type linux --os-variant rhel7 --ram 8000
> --vcpus 4
> attach it:
> virsh attach-interface --domain oza-guest --type network --source
> intel_pool --target eth1
> 
> kernel logs:
> [44287.825287] i40evf 0000:01:02.0: Unable to send opcode 2 to PF, err
> I40E_ERR_QUEUE_EMPTY, aq_err OK
> [44287.962640] i40e 0000:01:00.0: VF 0 still in reset. Try again.
> error: Failed to attach interface
> error: Cannot set interface MAC/vlanid to 52:54:00:e9:f1:b5/0 for
> ifname eth1 vf 0: Resource temporarily unavailable
> 
> 
> The same use case works with following card with the same kernel
> version and rootfs.
> Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 
> Lx]
> 
> for details logs please have a look at
> https://bugzilla.kernel.org/show_bug.cgi?id=198959
> 
> Regards,
> Oza.
