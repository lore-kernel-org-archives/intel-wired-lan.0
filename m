From: Aaron Ma <aaron.ma@canonical.com>
Date: Tue, 6 Jul 2021 14:42:01 +0800
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <CAPM=9twzx0aa5Dq-L5oOSk+w8z7audCq_biXwtFVh3QVY1VceA@mail.gmail.com>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
 <CAPM=9twzx0aa5Dq-L5oOSk+w8z7audCq_biXwtFVh3QVY1VceA@mail.gmail.com>
Message-ID: <53691935-daee-9acc-93d2-414fb11ce2bc@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/5/21 3:47 PM, Dave Airlie wrote:
> Drive-by, but won't this add a lot of overhead on every register
> access? has this been benchmarked with lots of small network transfers
> or anything?
> 

iperf3 is tested, the result is the same as before.
Due to the registers are rd/wr even after error_handler and remove.
Didn't find better fix.
Please let me know if you have any idea.

Thanks,
Aaron

> Dave.
