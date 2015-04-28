From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Tue, 28 Apr 2015 15:27:29 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbevf: add support for
 reporting RSS key and hash table for X550
In-Reply-To: <553F3CCE.10201@cloudius-systems.com>
References: <20150427203614.32710.54668.stgit@localhost6.localdomain6>
 <553F3CCE.10201@cloudius-systems.com>
Message-ID: <87618083B2453E4A8714035B62D67992502D21FC@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Vlad Zolotarov [mailto:vladz at cloudius-systems.com]
>Sent: Tuesday, April 28, 2015 12:55 AM
>To: Tantilov, Emil S; intel-wired-lan at lists.osuosl.org
>Subject: Re: [Intel-wired-lan] [net-next PATCH] ixgbevf: add support for
>reporting RSS key and hash table for X550
>
>On 04/27/15 23:36, Emil Tantilov wrote:
>> This patch extends the reporting of the RSS key and hash table by
>> adding support for X550 VFs. The difference is that X550 VFs have
>> their own registers for RSS key and indirection table, so there is
>> no need to query the PF.
>
>Although the patch itself looks correct, there is a minor remark below.
>
>The description is missing the mentioning that u have reworked the RSS
>hash table and RSS key initialization
>flow for x550 VFs. U've added the caching the corresponding values in
>the ixgbevf_adapter struct and set the HW from these caches.
>Then u've added some new macros which are clearly not a functional change.
>U've also changed the indirection table content layout (to match the
>actual index of the HW entry with the index in the rss_indir_tbl[]).

All of the changes are needed for the reporting of the RSS key and hash table.
Just about the only cleanup is replacing the magic number for the RSSRK registers
which is fairly obvious.

I can update the description of the patch, but I don't really see a need to split it.

Then again I'll leave it up to Jeff.

Thanks for reviewing.
Emil

