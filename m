From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 6 Jan 2021 15:45:16 +0200
Subject: [Intel-wired-lan] [RFC PATCH v2 net-next 00/12] Make
 .ndo_get_stats64 sleepable
In-Reply-To: <20210105185902.3922928-1-olteanv@gmail.com>
References: <20210105185902.3922928-1-olteanv@gmail.com>
Message-ID: <20210106134516.jnh2b5p5oww4cghz@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 05, 2021 at 08:58:50PM +0200, Vladimir Oltean wrote:
> This is marked as Request For Comments for a reason.

If nobody has any objections, I will remove the memory leaks I
introduced to check if anybody is paying attention, and I will resubmit
this as a non-RFC series.
