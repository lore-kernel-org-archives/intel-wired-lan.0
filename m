From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 25 Jul 2021 08:33:23 +0300
Subject: [Intel-wired-lan] What to do with info log message: `e1000e:
 EEE TX LPI TIMER: 00000011`?
In-Reply-To: <04a175b6-797c-ab25-dbd4-f8bdbb165674@molgen.mpg.de>
References: <04a175b6-797c-ab25-dbd4-f8bdbb165674@molgen.mpg.de>
Message-ID: <958198de-818f-cebb-ec68-06dd2d6accb8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/23/2021 15:28, Paul Menzel wrote:
> Dear David, dear Linux folks,
> 
> 
> On several devices, like the Dell OptiPlex 3620, Linux 5.10.47 (and 
> others) log the message below with info level (often during shutdown):
> 
>  ??? e1000e: EEE TX LPI TIMER: 00000011
> 
>  ??? $ git grep "LPI TIMER"
>  ??? drivers/net/ethernet/intel/e1000e/netdev.c:???? pr_info("EEE TX LPI 
> TIMER: %08X\n",
> 
Hello Paul,
I believe it is a simple debug print that has forgotten to remove.(more 
than seven years ago). It is comes just to inform: Low Power IDLE Entry 
Time - minimum time between low power idle entry and exit request.
You can process the patch to remove this line. (or I can do it and add 
you as "Suggested-by").
Thanks,
Sasha
> 
> What information is that supposed to provide? For a normal user it looks 
> like spam.
> 
> Could you please extend the message what to do about it? Or should it be 
> made a debug message?
> 
> 
> Kind regards,
> 
> Paul
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

