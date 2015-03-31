From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Tue, 31 Mar 2015 23:55:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v10 3/7] ixgbe: Add a RETA
 query command to VF-PF channel API
In-Reply-To: <1427787327.2497.111.camel@jtkirshe-mobl>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-4-git-send-email-vladz@cloudius-systems.com>
 <1427787327.2497.111.camel@jtkirshe-mobl>
Message-ID: <87618083B2453E4A8714035B62D67992502896D2@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jeff Kirsher
>Sent: Tuesday, March 31, 2015 12:35 AM
>Subject: Re: [Intel-wired-lan] [PATCH net-next v10 3/7] ixgbe: Add a RETA query command to VF-PF channel API
>
>On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
>> Add this new command for 82599 and x540 devices only. Support for
>> other devices
>> will be added later.
>> 
>> 82599 and x540 VFs and PF share the same RSS redirection table (RETA).
>> Therefore we just return it for all VFs.
>> 
>> For 82599 and x540 RETA table is an array of 32 registers (128 bytes)
>> and the maximum number of registers that may be delivered in a single VF-PF channel command is
>> 15. Therefore we will deliver the whole table in 3 steps: 12, 12 and 8 registers in
>> each step correspondingly.

The above paragraph no longer applies to this patch. Perhaps Jeff can strip it to avoid having to resend the 
patch just for the description.

Thanks,
Emil

