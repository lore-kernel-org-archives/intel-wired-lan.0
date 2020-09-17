From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Thu, 17 Sep 2020 20:06:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 06/10]
 drivers/net/ethernet: handle one warning explicitly
In-Reply-To: <e15b85af416c7257aaa601901b18c7c9bc9586e0.camel@kernel.org>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
 <20200915014455.1232507-7-jesse.brandeburg@intel.com>
 <e15b85af416c7257aaa601901b18c7c9bc9586e0.camel@kernel.org>
Message-ID: <3C4D967A-183C-4EA9-BA87-CE6731C24AAF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

at 8:25 PM, Saeed Mahameed <saeed@kernel.org> wrote:

> I don't have any strong feeling against disabling compiler warnings,
> but maybe the right thing to do here is to initialize the gaps to the
> invalid value instead of pre-initializing the whole thing first and
> then setting up the valid values on the 2nd pass.
>
> I don't think there are too many gaps to fill, it is doable, so maybe
> add this as a comment to this driver maintainer so they could pickup
> the work from here.

The problem is that filling in the gaps creates a maintenance hazard. As  
another example, the kernel does exactly this kind of thing to initialize  
the system call table. Using the override in this way is the clearest,  
easiest to maintain way of expressing this.

Disabling the warning not only gets rid of the warning, but should also be  
seen as a "something special is happening here" flag in the code. With the  
warning disabled, there is a hazard of now missing the possible  
introduction of an override here, but I think that risk is less than the  
risk of failing to fill a gap when changes are made.

I completely support doing this in exactly this way.

--
Mark Rustad, Ethernet Products Group, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 873 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200917/ecd370e2/attachment.asc>
