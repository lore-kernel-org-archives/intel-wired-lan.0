From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Fri, 30 Nov 2018 15:37:18 +0000
Subject: [Intel-wired-lan] Any idea when 2.5G Ethernet NICs will be
 available?
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD69A4D0E57@ORSMSX110.amr.corp.intel.com>
References: <05fccb2a-284b-de94-9bd6-e295e87a8796@candelatech.com>
 <9B4A1B1917080E46B64F07F2989DADD69A4D0DE3@ORSMSX110.amr.corp.intel.com>
 <dbe24a68-5732-b900-f70f-5b04b98c255b@candelatech.com>
 <9B4A1B1917080E46B64F07F2989DADD69A4D0E57@ORSMSX110.amr.corp.intel.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD69A4D1113@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver developers tell me that my understanding is correct, and if you have a 2.5G partner the x550 will do 2.5G. No way to force it, though. I think this is a limitation of the driver.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Fujinaka, Todd
Sent: Thursday, November 29, 2018 3:03 PM
To: Ben Greear <greearb@candelatech.com>; intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] Any idea when 2.5G Ethernet NICs will be available?

It should work with the ixgbe driver, but I'm not sure if you can explicitly set 2.5G. Let me ask around.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Ben Greear [mailto:greearb at candelatech.com]
Sent: Thursday, November 29, 2018 2:08 PM
To: Fujinaka, Todd <todd.fujinaka@intel.com>; intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] Any idea when 2.5G Ethernet NICs will be available?

At this point, functionality is more important than price for me.

Do I need any special driver changes (or very recent drivers) to make this work with 2.5G?

Thanks,
Ben

On 11/29/2018 02:04 PM, Fujinaka, Todd wrote:
> The Intel(r) Ethernet Converged Network Adapter X550-T1 and -T2 should do 2.5G but I'm guessing you're looking for a lower cost solution.
>
> Todd Fujinaka
> Software Application Engineer
> Datacenter Engineering Group
> Intel Corporation
> todd.fujinaka at intel.com
>
> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On 
> Behalf Of Ben Greear
> Sent: Thursday, November 29, 2018 8:59 AM
> To: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] Any idea when 2.5G Ethernet NICs will be available?
>
> Hello,
>
> I notice there is some driver support coming soon for a 2.5G Intel NIC.
>
> Anyone know when we might expect to be able to buy pcie NICs with this chipset?
>
> Thanks,
> Ben
>


--
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
