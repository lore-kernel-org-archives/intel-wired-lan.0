From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 3 Apr 2020 09:37:26 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when
 ME un-configure ULP mode
In-Reply-To: <1c0e602f-1fe7-62b1-2283-b98783782e87@canonical.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <4f9f1ad0-e66a-d3c8-b152-209e9595e5d7@redhat.com>
 <1c0e602f-1fe7-62b1-2283-b98783782e87@canonical.com>
Message-ID: <2d7c1890-9cd8-8134-af12-5c55cd7e1a8e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


Am 03.04.20 um 05:15 schrieb Aaron Ma:

> I have received the email that you apply this patch to next-queue branch
> dev-queue.
> 
> But after this branch is rebased to v5.6, I can't find it.
> 
> Will you apply again?

I really urge you to write more elaborate commit messages.

The exact error is not listed. The known regressed devices are not 
listed, so possible testers cannot easily test or affected people cannot 
find it, when searching the Linux git history.

How did you find out, that ME takes more than two seconds?

Also, it?s not clear, what effect increasing the timeout has. Does the 
whole resume process take longer or just getting the Ethernet device 
back up?

Lastly, in case of the timeout, an error message should be printed, so 
people with even more broken ME devices, get a clue.

Without this information, how can anybody know, if this is the right fix 
and distributions, if it should be backported?


Kind regards,

Paul
