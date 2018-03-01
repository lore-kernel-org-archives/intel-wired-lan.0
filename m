From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Thu, 1 Mar 2018 09:29:32 +0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add receive length error
 counter.
In-Reply-To: <1519838252.7902.3.camel@intel.com>
References: <1519819149-10012-1-git-send-email-xiangxia.m.yue@gmail.com>
 <1519838252.7902.3.camel@intel.com>
Message-ID: <CAMDZJNXLpaM1wDrWcEmrx6NVOA9Hiv+DjM_kZkeJ8RhaL-cc4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 1, 2018 at 1:17 AM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Wed, 2018-02-28 at 03:59 -0800, Tonghao Zhang wrote:
>> ixgbe enabled rlec counter and the rx_error used it.
>> We can export the counter directly via ethtool -S ethX.
>>
>> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> A minor nitpick, your patch title/subject ending in a period which is
> not needed or wanted.  Patch titles/subjects should not be complete
> sentences, so they do not need punctuation at the end.
Jeff, thanks for your tips.
