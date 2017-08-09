From: Rafael J. Wysocki <rjw@rjwysocki.net>
Date: Wed, 09 Aug 2017 02:45:54 +0200
Subject: [Intel-wired-lan] [regression] wake on lan no longer works in
	4.13-rc3. was Re: Linux 4.13: Reported regressions as of
	Sunday, 2017-08-06
In-Reply-To: <20170808090053.GA3066@amd>
References: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
 <20170808090053.GA3066@amd>
Message-ID: <15027171.LoAvHuklGv@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tuesday, August 8, 2017 11:00:53 AM CEST Pavel Machek wrote:
> Hi!
> 
> Perhaps you should get regressions at kernel.org alias, or something like that?
> 
> > As always: Are you aware of any other regressions? Then please let me
> > know. For details see http://bit.ly/lnxregtrackid And please tell me if
> > there is anything in the report that shouldn't be there.
> 
> I am using wake-on-lan quite a bit, and it stopped working. I'll move
> to -rc4 and test there; but if anyone already has some ideas, let me
> know.
> 
> Hardware is thinkpad X220
> 
> 00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network
> Connection (rev 04)

I guess this is ACPI S3 suspend?

Thanks,
Rafael

