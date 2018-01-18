From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 18 Jan 2018 09:11:22 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
Message-ID: <20180118171122.3pnrws3o3dvh54u2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 17, 2018 at 03:06:12PM -0800, Jesus Sanchez-Palencia wrote:
> @@ -2130,6 +2137,15 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
>  		sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
>  		sockc->tsflags |= tsflags;
>  		break;
> +	case SO_TXTIME:
> +		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
> +			return -EPERM;
> +		if (!sock_flag(sk, SOCK_TXTIME))
> +			return -EINVAL;
> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(ktime_t)))
> +			return -EINVAL;
> +		sockc->transmit_time = *(ktime_t *)CMSG_DATA(cmsg);

As pointed out in the first series' review:

  No guarantee the CMSG is properly aligned on arches that might trap
  on unaligned access.

Thanks,
Richard
