From: Josh Hunt <johunt@akamai.com>
Date: Thu, 10 Oct 2019 17:27:43 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] igb, ixgbe,
 i40e UDP segmentation offload support
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B9714C727@ORSMSX103.amr.corp.intel.com>
References: <1570658777-13459-1-git-send-email-johunt@akamai.com>
 <CAKgT0UdBPYRnwAuOGhCBAJSRhdHcnw28Tznr0GPAtqe-JWFjTQ@mail.gmail.com>
 <cd8ac880-61fe-b064-6271-993e8c6eee65@akamai.com>
 <CAKgT0UfXgzur2TGv1dNw0PQXAP0C=bNoJY6gnthASeQrHr66AA@mail.gmail.com>
 <0e0e706c-4ce9-c27a-af55-339b4eb6d524@akamai.com>
 <309B89C4C689E141A5FF6A0C5FB2118B9714C727@ORSMSX103.amr.corp.intel.com>
Message-ID: <71a74c86-18b6-5c6a-8663-e558c43af682@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/10/19 5:21 PM, Brown, Aaron F wrote:
> Adding Andrew as he is most likely going to be testing this patch.
> 
> Unfortunately my mail server flags attached scripts as potential threats and strips them out.  Can you resent it as an tar file?  I don't believe it's smart enough to open up tar and flag it as a script.
> 

Hi Aaron

It looks like the netdev archive has the file. Can you try grabbing it 
from here?

https://lore.kernel.org/netdev/0e0e706c-4ce9-c27a-af55-339b4eb6d524 at akamai.com/2-udpgso_bench.sh

If that doesn't work I can try your tar workaround.

Thanks
Josh
