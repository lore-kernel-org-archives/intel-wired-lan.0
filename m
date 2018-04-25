From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 24 Apr 2018 20:30:13 -0700
Subject: [Intel-wired-lan] [BUG] igb: reconnecting of cable not always
 detected
In-Reply-To: <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
References: <87h8o0ocul.fsf@gmail.com>
 <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
Message-ID: <20180425033013.wsguf6w36zeua3mw@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Apr 24, 2018 at 11:09:02AM -0700, Alexander Duyck wrote:
> On Tue, Apr 24, 2018 at 8:14 AM, Holger Schurig <holgerschurig@gmail.com> wrote:
> > Sometimes, plugging the cable back in is detected ...
> >
> > [   43.736922] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
> >
> > ... but sometimes this is *NOT* detected. I can put the cable in and
> > even after two minutes nothing has been detected.
> >
> > But when I run "rmmod igb" followed by "modpobe igb", the link is
> > detected again:

FWIW, I have noticed over the past months (or even years?) that my
i210 cards (or the igb driver) also fail to detect link changes after
a few physical link interruptions.  I never bothered to try and debug
this, but it is super annoying.

Thanks,
Richard
