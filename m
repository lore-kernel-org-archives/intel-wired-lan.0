From: Lifshits, Vitaly <vitaly.lifshits@intel.com>
Date: Wed, 29 May 2019 14:33:13 +0300
Subject: [Intel-wired-lan] Driver has suspect GRO implementation,
 TCP performance may be compromised.
In-Reply-To: <8627ea1e-8e51-c425-97f6-aeb57176e11a@gmail.com>
References: <e070e241-fb65-a5b0-3155-7380a9203bcf@molgen.mpg.de>
 <8627ea1e-8e51-c425-97f6-aeb57176e11a@gmail.com>
Message-ID: <aa7c6d4c-e93b-4ec2-c5d1-0f781ae6d8da@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/28/2019 20:18, Eric Dumazet wrote:
>
> On 5/28/19 8:42 AM, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> Occasionally, Linux outputs the message below on the workstation Dell
>> OptiPlex 5040 MT.
>>
>>      TCP: net00: Driver has suspect GRO implementation, TCP performance may be compromised.
>>
>> Linux 4.14.55 and Linux 5.2-rc2 show the message, and the WWW also
>> gives some hits [1][2].
>>
>> ```
>> $ sudo ethtool -i net00
>> driver: e1000e
>> version: 3.2.6-k
>> firmware-version: 0.8-4
>> expansion-rom-version:
>> bus-info: 0000:00:1f.6
>> supports-statistics: yes
>> supports-test: yes
>> supports-eeprom-access: yes
>> supports-register-dump: yes
>> supports-priv-flags: no
>> ```
>>
>> Can the driver e1000e be improved?
>>
>> Any idea, what triggers this, as I do not see it every boot? Download
>> of big files?
>>
> Maybe the driver/NIC can receive frames bigger than MTU, although this would be strange.
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index c61edd023b352123e2a77465782e0d32689e96b0..cb0194f66125bcba427e6e7e3cacf0c93040ef61 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -150,8 +150,10 @@ static void tcp_gro_dev_warn(struct sock *sk, const struct sk_buff *skb,
>                  rcu_read_lock();
>                  dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
>                  if (!dev || len >= dev->mtu)
> -                       pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised.\n",
> -                               dev ? dev->name : "Unknown driver");
> +                       pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised."
> +                               " len %u mtu %u\n",
> +                               dev ? dev->name : "Unknown driver",
> +                               len, dev ? dev->mtu : 0);
>                  rcu_read_unlock();
>          }
>   }
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

On some devices due to hardware limitation there's a drop in TCP 
performance.

This is described in this data sheet:

https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/i218-i219-ethernet-connection-spec-update.pdf?asset=9561

And in this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/drivers/net/ethernet/intel/e1000e?id=b10effb92e272051dd1ec0d7be56bf9ca85ab927


Disabling TSO fixes the performance drop.

