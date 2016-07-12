From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Tue, 12 Jul 2016 00:37:41 +0000
Subject: [Intel-wired-lan] [BUG] Panic on boot in ixgbe with Xeon D-1531
In-Reply-To: <CAE2NFgU+p3jq2ERHDBvZGc=nf0qqjmY0WKGT-oSteeTqmoMj7w@mail.gmail.com>
References: <CAE2NFgU+p3jq2ERHDBvZGc=nf0qqjmY0WKGT-oSteeTqmoMj7w@mail.gmail.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664696AC91FF@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The igbvf is a bit of a red herring since it is not the VF driver for ixgbe and sriov isn't enable on this boot anyway as we can tell by the number of queue allocated.

As for the panic I believe we already have a patch, but if you could supply the DevID we could tell you for sure.

Thanks,
-Don Skidmore <donald.c.skidmore@intel.com>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Patrick McLean
> Sent: Thursday, June 30, 2016 9:12 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [BUG] Panic on boot in ixgbe with Xeon D-1531
> 
> Hi,
> 
> We are getting a panic on boot with Linus git as of this morning. I have
> attached the boot log, it looks like the panic is in igbvf/ixgbe.
> The machine is being netbooted via legacy PXE.
> 
> I have attached the full boot log from a kernel with igbvf enabled, and one log
> of just the panic message with igbvf disabled. Please let me know if you need
> any more information.
