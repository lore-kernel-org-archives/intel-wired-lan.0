From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 15 Jul 2020 13:31:36 -0700
Subject: [Intel-wired-lan] NAT performance issue 944mbit -> ~40mbit
In-Reply-To: <CAA85sZua6Q8UR7TfCGO0bV=VU0gKtqj-8o_mqH38RpKrwYZGtg@mail.gmail.com>
References: <CAA85sZvKNXCo5bB5a6kKmsOUAiw+_daAVaSYqNW6QbSBJ0TcyQ@mail.gmail.com>
 <CAA85sZua6Q8UR7TfCGO0bV=VU0gKtqj-8o_mqH38RpKrwYZGtg@mail.gmail.com>
Message-ID: <20200715133136.5f63360c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 15 Jul 2020 22:05:58 +0200 Ian Kumlien wrote:
> After a  lot of debugging it turns out that the bug is in igb...
> 
> driver: igb
> version: 5.6.0-k
> firmware-version:  0. 6-1
> 
> 03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network
> Connection (rev 03)

Unclear to me what you're actually reporting. Is this a regression
after a kernel upgrade? Compared to no NAT?

> It's interesting that it only seems to happen on longer links... Any clues?

Links as in with longer cables?
