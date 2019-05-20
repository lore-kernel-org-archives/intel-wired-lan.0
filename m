From: Arjan van de Ven <arjan@linux.intel.com>
Date: Sun, 19 May 2019 22:42:52 -0700
Subject: [Intel-wired-lan] [PATCH] Reduce e1000e boot time by tightening
 sleep ranges
In-Reply-To: <9e2407a7-09c6-884d-e3e0-0af808552831@intel.com>
References: <8ef1b846-caf6-45de-33aa-a46406548167@molgen.mpg.de>
 <057ec48b-6d98-7177-d280-15679c8e66ac@molgen.mpg.de>
 <9e2407a7-09c6-884d-e3e0-0af808552831@intel.com>
Message-ID: <aed005cb-163a-3af5-2857-4ca7e9867d27@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/19/2019 10:31 PM, Neftin, Sasha wrote:
> The e1000e driver supports a pretty long list of 1G devices. We are afraid that initialization flow could be a break for some devices. Although this works on BDW,? we 
> cannot confirm this for all other devices.

Hi

this is not a valid argument against this patch. The patch does not reduce the specified minimum delays, it only reduces the maximum delays.
If the minimum delays are not actually correct your drivers is already buggy since the kernel already does not guarantee that you get more than the minimum,
depending on what else is going on you are getting something arbitrary between minimum and maxium.

this patch  moves the maximum closer to the minimum reducing variability

