From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 9 Nov 2017 16:16:01 -0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <008a7e8d-86e2-0709-d2ae-8aa743ef12ac@oracle.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CAKgT0UfSTwTsQFP9ir=aOJDz-BvYONBd3Q6SOJWQherkQ8XpFQ@mail.gmail.com>
 <20171109031206.x6ta5ysdalf3lk3s@wfg-t540p.sh.intel.com>
 <CAM_iQpXJ1cqJKkp9X1-56gUi4V_s7Gbx_GPo=rgXzJ_LwY+v7w@mail.gmail.com>
 <008a7e8d-86e2-0709-d2ae-8aa743ef12ac@oracle.com>
Message-ID: <CAM_iQpUBDHkrC4kirFdM6ff==9dot5+q+8L_fx2vfRLq+2+Zqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 9, 2017 at 7:51 AM, Girish Moodalbail
<girish.moodalbail@oracle.com> wrote:
>
> Upon receiving NETDEV_DOWN event, we are calling
>
>         vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
>
> which in turn calls call_rcu() to queue vlan_info_free_rcu() to be called at
> some point. This free function frees the array[]
> (vlan_info.vlan_grp.vn_devices_array).  My guess is that
> vlan_info_free_rcu() is being called first and then the array[] is being
> accessed in vlan_device_event().
>

Well yes and no.

No, RCU itself is not broken and we clearly unpublish the RCU pointer
before calling call_rcu().

Yes, I see where it is broken: the grp pointer still points to old
dev->vlan_info, we should re-fetch it after vlan_vid_del().

I will send a fix.

Thanks!
