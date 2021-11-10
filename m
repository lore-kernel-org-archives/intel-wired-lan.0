From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 10 Nov 2021 12:05:57 +0300
Subject: [Intel-wired-lan] [PATCH net] iavf: missing unlocks in
 iavf_watchdog_task()
In-Reply-To: <89022668-5c63-bf19-a768-6bef2a3be3b0@molgen.mpg.de>
References: <20211110081350.GI5176@kili>
 <89022668-5c63-bf19-a768-6bef2a3be3b0@molgen.mpg.de>
Message-ID: <20211110090557.GL2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 10, 2021 at 09:53:50AM +0100, Paul Menzel wrote:
> Dear Dan,
> 
> 
> Thank you for your patch.
> 
> For the future, just a nit for the commit message summary. Could you make it
> a statement by adding a verb (in imperative mood) [1].
> 
> > iavf: Add missing unlocks in iavf_watchdog_task()
> 

Imperative shmeritave.

When subsystems get taken over by fussy bureaucrats then I only send
them bug reports instead of patches.

regards,
dan carpenter
