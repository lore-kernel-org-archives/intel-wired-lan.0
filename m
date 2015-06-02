From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 01 Jun 2015 20:18:53 -0700
Subject: [Intel-wired-lan] vlan packet handling in ixgbevf driver when
 in promiscuous mode
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05EBFFBA@BPXM14GP.gisp.nec.co.jp>
References: <5568D344.9090903@windriver.com>
 <C5551D9AAB213A418B7FD5E4A6F30A078930269A@ORSMSX108.amr.corp.intel.com>
 <556CF268.2060703@windriver.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EBFFBA@BPXM14GP.gisp.nec.co.jp>
Message-ID: <556D209D.9030001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/01/2015 05:47 PM, Hiroshi Shimamoto wrote:
>> Subject: Re: [Intel-wired-lan] vlan packet handling in ixgbevf driver when in promiscuous mode
>>
>> Could you elaborate?
>>
>> The use-case here is for NFV/SDN type stuff, where we want to be able to run a
>> router or something similar in the guest--so it needs to be able to receive
>> packets from all VLANs.
>>
>>   From what I see if you enable promiscuous mode on the PF then the VFs get
>> packets from all VLANs.
> I'd like to have and am working to add a functionality to disable VLAN filter on PF
> to pass all VLANs to VFs in stock kernel ixgbe driver.
> How did you do that?
>
>> With the stock ixgbevf driver in the guest this doesn't work well because any
>> packets from VLANs that the guest hasn't registered for do not get the vlan tags
>> added back in to the packets (which makes it useless for routing).  With a minor
>> change to the ixgbevf driver to put the vlan tags back in for all packets it
>> seems to work okay.  Maybe this change would be a reasonable thing to do in the
>> stock ixgbevf driver when enabling promiscuous mode in the guest?
> I just have confirmed that behavior during my work, and thought something to do to
> fix this issue.
>
> Currently ixgbevf driver relies on VLAN filtering, that leads to this issue.
>
> Dropping unregistered VLAN packet is expected behavior, I think.
> I'm not sure whether we should implement to capture unknown VLAN packet in VF.
>
> What do you think?
>
> thanks,
> Hiroshi

Hiroshi,

What I would recommend doing is looking at something like 
fm10k_process_skb_fields and possibly working on updating ixgbevf to 
work similarly.  Basically you need to be able to determine when the VF 
has a port VLAN enabled, and when it does it needs to know what the port 
VLAN ID is so that you can correctly strip that tag on incoming frames.  
This is why I said your change would break legacy drivers by enabling 
VLAN promiscuous mode.

What you would probably need to do is setup a new API version and find a 
way of passing a notification that a port VLAN has been assigned.  Once 
you have that then you could look at rewriting the VLAN ID check so that 
you could pass all VLAN tagged frames that are not the port VLAN up to 
the stack as VLAN tagged.

- Alex
