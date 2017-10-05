From: David Miller <davem@davemloft.net>
Date: Thu, 05 Oct 2017 11:29:09 -0700 (PDT)
Subject: [Intel-wired-lan] [next-queue PATCH v4 3/4] net/sched:
 Introduce Credit Based Shaper (CBS) qdisc
In-Reply-To: <CAEYbN3RjUXGMyxo0t88-ASNVEVQdfXkMzBbMtMHAhqWScOO=Cg@mail.gmail.com>
References: <20171004002831.18371-4-vinicius.gomes@intel.com>
 <20171004063650.GA1895@nanopsycho>
 <CAEYbN3RjUXGMyxo0t88-ASNVEVQdfXkMzBbMtMHAhqWScOO=Cg@mail.gmail.com>
Message-ID: <20171005.112909.2052593524154643514.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Levi Pearson <levipearson@gmail.com>
Date: Thu, 5 Oct 2017 12:09:32 -0600

> It would be a shame if this were blocked due to a missing software
> implementation.

Quite the contrary, I think a software implementation is a minimum
requirement for inclusion of this feature.

Without a software implementation, there is no clear definition of
what is supposed to happen, and no clear way for people to test those
expectations unless they have the specific hardware.

I completely agree with Jiri.  Hardware offload first is _not_ how
we do things in the Linux networking.
