From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 20 May 2019 08:31:32 +0300
Subject: [Intel-wired-lan] [PATCH] Reduce e1000e boot time by tightening
 sleep ranges
In-Reply-To: <057ec48b-6d98-7177-d280-15679c8e66ac@molgen.mpg.de>
References: <8ef1b846-caf6-45de-33aa-a46406548167@molgen.mpg.de>
 <057ec48b-6d98-7177-d280-15679c8e66ac@molgen.mpg.de>
Message-ID: <9e2407a7-09c6-884d-e3e0-0af808552831@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/17/2019 17:58, Paul Menzel wrote:
> Dear Jeff,
> 
> 
> Mozilla Thunderbird probably mangled the patch, so please find it attached.
> 
> 
> Kind regards,
> 
> Paul
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
The e1000e driver supports a pretty long list of 1G devices. We are 
afraid that initialization flow could be a break for some devices. 
Although this works on BDW,  we cannot confirm this for all other devices.
