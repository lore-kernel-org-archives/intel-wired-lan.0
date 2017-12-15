From: David Miller <davem@davemloft.net>
Date: Fri, 15 Dec 2017 10:52:10 -0500 (EST)
Subject: [Intel-wired-lan] v4.15-rc2 on thinkpad x60: ethernet stopped
 working
In-Reply-To: <20171215092849.GB15090@amd>
References: <20171210083949.GA3872@amd>
 <d1ae924b-4d8f-a787-4c07-1f2db91482e5@gmail.com>
 <20171215092849.GB15090@amd>
Message-ID: <20171215.105210.103516329605719086.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 15 Dec 2017 10:28:49 +0100

> Hi!
> 
>> >In v4.15-rc2+, network manager can not see my ethernet card, and
>> >manual attempts to ifconfig it up did not really help, either.
>> >
>> >Card is:
>> >
>> >02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
>> >Controller
> ....
>> >Any ideas ?
>> 
>> Yes , 19110cfbb34d4af0cdfe14cd243f3b09dc95b013 broke it.
>> 
>> See:
>> https://bugzilla.kernel.org/show_bug.cgi?id=198047
>> 
>> Fix there :
>> https://marc.info/?l=linux-kernel&m=151272209903675&w=2
> 
> I don't see the patch in latest mainline. Not having ethernet
> is... somehow annoying. What is going on there?

Generally speaking, e1000 maintainence has been handled very poorly over
the past few years, I have to say.

Fixes take forever to propagate even when someone other than the
maintainer provides a working and tested fix, just like this case.

Jeff, please take e1000 maintainence seriously and get these critical
bug fixes propagated.

Thank you.
