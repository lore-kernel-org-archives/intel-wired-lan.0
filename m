From: David Miller <davem@davemloft.net>
Date: Mon, 26 Nov 2018 20:52:47 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
In-Reply-To: <F6168EB4-8C74-456F-B571-6492162CFA0F@appneta.com>
References: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
 <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
 <F6168EB4-8C74-456F-B571-6492162CFA0F@appneta.com>
Message-ID: <20181126.205247.1196368459821644290.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Josh Elsasser <jelsasser@appneta.com>
Date: Mon, 26 Nov 2018 16:54:11 -0800

> Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
> 
>> No need to re-spin the patch, just reply with the additional "Fixes"
>> tag and if patchwork does not pick it up, I will add it to the patch I
>> have in my tree for validation and review.
> 
> Thanks, let?s try that.
> 
> Fixes: e23f33367882 ("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+?)

Unfortunately, patchwork isn't smart enough to pick up Fixes: tags
still.
