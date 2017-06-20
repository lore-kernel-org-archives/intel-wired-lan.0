From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Tue, 20 Jun 2017 14:55:52 +0200
Subject: [Intel-wired-lan] [PATCH] igb: protect TX timestamping from API
 misuse
In-Reply-To: <20170619203043.120598-1-cspradlin@google.com>
References: <20170619203043.120598-1-cspradlin@google.com>
Message-ID: <20170620125552.GB10520@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jun 19, 2017 at 01:30:43PM -0700, Cliff Spradlin wrote:
> HW timestamping can only be requested for a packet if the NIC is first
> setup via ioctl(SIOCSHWTSTAMP). If this step was skipped, then the igb
> driver still allowed TX packets to request HW timestamping. In this
> situation, the _IGB_PTP_TX_IN_PROGRESS flag was set and would never
> clear. This prevented any future HW timestamping requests to succeed.

Good catch!

This probably explains some weird cases I saw where HW timestamping
stopped working and the only thing that fixed it was to rmmod &&
modprobe the igb driver. I suspected a faulty HW and it's probably
just me messing with hwstamp_ctl at wrong time.

Thanks,

-- 
Miroslav Lichvar
