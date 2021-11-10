From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 10 Nov 2021 10:27:16 +0100
Subject: [Intel-wired-lan] [PATCH net] iavf: missing unlocks in
 iavf_watchdog_task()
In-Reply-To: <20211110090557.GL2001@kadam>
References: <20211110081350.GI5176@kili>
 <89022668-5c63-bf19-a768-6bef2a3be3b0@molgen.mpg.de>
 <20211110090557.GL2001@kadam>
Message-ID: <38c47f1b-f153-6c79-2ec5-ed4332c52f6c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Dan,


Am 10.11.21 um 10:05 schrieb Dan Carpenter:
> On Wed, Nov 10, 2021 at 09:53:50AM +0100, Paul Menzel wrote:

>> Thank you for your patch.
>>
>> For the future, just a nit for the commit message summary. Could you make it
>> a statement by adding a verb (in imperative mood) [1].
>>
>>> iavf: Add missing unlocks in iavf_watchdog_task()
> 
> Imperative shmeritave.
> 
> When subsystems get taken over by fussy bureaucrats then I only send
> them bug reports instead of patches.

It was just a wish as the standard commit messages follow that format, 
and any verb could be added. It?s not a requirement to my knowledge, and 
I do not have any authority anyway. Sorry about that, and thank you for 
your patches.


Kind regards,

Paul
