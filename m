From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 12 Oct 2018 07:08:03 -0700
Subject: [Intel-wired-lan] [PATCH] igb: shorten maximum PHC timecounter
 update interval
In-Reply-To: <20181012111339.1361-1-mlichvar@redhat.com>
References: <20181012111339.1361-1-mlichvar@redhat.com>
Message-ID: <20181012140803.pcipk3qw4wvtyhxu@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 12, 2018 at 01:13:39PM +0200, Miroslav Lichvar wrote:
> This fixes an issue with HW timestamps on 82580/I350/I354 being off by
> ~1100 seconds for few seconds every ~9 minutes.

This patch should go to the stable trees starting with v4.8.

Thanks,
Richard
