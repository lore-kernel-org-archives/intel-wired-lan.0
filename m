From: Vasily Averin <vvs@virtuozzo.com>
Date: Tue, 07 Jul 2015 20:25:18 +0300
Subject: [Intel-wired-lan] [PATCH 3/3] ipmr_free_table() should be
	called under taken rtnl_lock
In-Reply-To: <CAM_iQpW1zo4T3AyZsv7ofLLsFtAfnqzGuDcqcFKxw9uuRNk_vA@mail.gmail.com>
References: <559BF613.7090904@virtuozzo.com>
 <CAM_iQpW1zo4T3AyZsv7ofLLsFtAfnqzGuDcqcFKxw9uuRNk_vA@mail.gmail.com>
Message-ID: <559C0B7E.8010108@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 07.07.2015 20:13, Cong Wang wrote:
> On Tue, Jul 7, 2015 at 8:53 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>> ipmr_free_table() calls unregister_netdevice_many() inside
>> and changes net_todo_list protected by rtnl_lock
> 
> Did you see any real bug?

No, it was result of manual code review.

> ipmr_free_table() is called in failure path, in this case there is no
> device registered yet, so unregister should be just a nop?

However may be it's better to mark this place for future anyway?
