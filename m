From: David Miller <davem@davemloft.net>
Date: Thu, 08 Mar 2018 11:25:53 -0500 (EST)
Subject: [Intel-wired-lan] [RFC v3 net-next 08/18] net: SO_TXTIME: Add
 clockid and drop_if_late params
In-Reply-To: <20180308113722.GB28493@localhost>
References: <b612233d-cad6-9fb3-0d08-763bc25553c1@intel.com>
 <1520462745.109662.59.camel@gmail.com>
 <20180308113722.GB28493@localhost>
Message-ID: <20180308.112553.749777250006660851.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Thu, 8 Mar 2018 12:37:22 +0100

> Well, I'd not expect it to be a common use case, but a public NTP
> server could be sending millions of packets per second in traffic
> peaks (typically at *:00:00) over multiple interfaces.

That's the problem.

Bloating up sk_buff for an uncommon use case, penalizing all others,
is a non-starter.

Sorry.
