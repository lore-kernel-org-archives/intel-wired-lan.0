From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Apr 2018 10:33:13 -0700
Subject: [Intel-wired-lan] [iwl next-queue PATCH 02/10] macvlan: Rename
 fwd_priv to accel_priv and add accessor function
In-Reply-To: <7b6a4392-ed51-4324-9b2e-fa483f769882@oracle.com>
References: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
 <20180403211603.7880.2593.stgit@ahduyck-green-test.jf.intel.com>
 <7b6a4392-ed51-4324-9b2e-fa483f769882@oracle.com>
Message-ID: <CAKgT0UdoyyRTbxJsdGfxNQqn-_G1Rid7xpNVpYWJYp9-DFN+9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 4, 2018 at 9:53 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 4/3/2018 2:16 PM, Alexander Duyck wrote:
>
> [...]
>>
>>   +static inline void *macvlan_accel_priv(struct net_device *dev)
>> +{
>> +       struct macvlan_dev *macvlan = netdev_priv(dev);
>> +
>> +       return macvlan->accel_priv;
>
>
> Perhaps a check for (macvlan == NULL) before using it?
> sln
>
>

The macvlan pointer cannot be NULL.The netdev_priv() function adds an
offset to the dev pointer. So I would have to be checking for a NULL
netdev. If the netdev was NULL then there was probably no point in
calling this function in the first place.

- Alex
