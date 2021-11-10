From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 10 Nov 2021 09:53:50 +0100
Subject: [Intel-wired-lan] [PATCH net] iavf: missing unlocks in
 iavf_watchdog_task()
In-Reply-To: <20211110081350.GI5176@kili>
References: <20211110081350.GI5176@kili>
Message-ID: <89022668-5c63-bf19-a768-6bef2a3be3b0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Dan,


Thank you for your patch.

For the future, just a nit for the commit message summary. Could you 
make it a statement by adding a verb (in imperative mood) [1].

 > iavf: Add missing unlocks in iavf_watchdog_task()


Kind regards,

Paul


[1]: https://chris.beams.io/posts/git-commit/
