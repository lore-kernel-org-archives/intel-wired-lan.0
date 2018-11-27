From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 27 Nov 2018 10:07:24 -0800
Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
In-Reply-To: <20181126.205247.1196368459821644290.davem@davemloft.net>
References: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
 <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
 <F6168EB4-8C74-456F-B571-6492162CFA0F@appneta.com>
 <20181126.205247.1196368459821644290.davem@davemloft.net>
Message-ID: <9e45af90-0a62-79a1-8eac-0bc27cf3d531@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/26/2018 8:52 PM, David Miller wrote:
> From: Josh Elsasser <jelsasser@appneta.com>
> Date: Mon, 26 Nov 2018 16:54:11 -0800
> 
>> Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
>>
>>> No need to re-spin the patch, just reply with the additional "Fixes"
>>> tag and if patchwork does not pick it up, I will add it to the patch I
>>> have in my tree for validation and review.
>>
>> Thanks, let?s try that.
>>
>> Fixes: e23f33367882 ("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+?)
> 
> Unfortunately, patchwork isn't smart enough to pick up Fixes: tags
> still.
> 

This is something that can be added easily in the patchwork
administration panel, maybe ask Jeremy or Stephen to do that?
-- 
Florian
