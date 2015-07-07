From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 7 Jul 2015 10:13:05 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] ipmr_free_table() should be
	called under taken rtnl_lock
In-Reply-To: <559BF613.7090904@virtuozzo.com>
References: <559BF613.7090904@virtuozzo.com>
Message-ID: <CAM_iQpW1zo4T3AyZsv7ofLLsFtAfnqzGuDcqcFKxw9uuRNk_vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jul 7, 2015 at 8:53 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
> ipmr_free_table() calls unregister_netdevice_many() inside
> and changes net_todo_list protected by rtnl_lock
>

Did you see any real bug?

ipmr_free_table() is called in failure path, in this case there is no
device registered yet, so unregister should be just a nop?
