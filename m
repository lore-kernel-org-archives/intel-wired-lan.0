From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 17 Dec 2019 18:33:14 +0100
Subject: [Intel-wired-lan] [PATCH bpf v2 0/4] Fix concurrency issues
 between XSK wakeup and control path using RCU
In-Reply-To: <20191217162023.16011-1-maximmi@mellanox.com>
References: <20191217162023.16011-1-maximmi@mellanox.com>
Message-ID: <cfe64691-7a0f-5b8a-d511-ebe742cec3c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-12-17 17:20, Maxim Mikityanskiy wrote:
> This series addresses the issue described in the commit message of the
> first patch: lack of synchronization between XSK wakeup and destroying
> the resources used by XSK wakeup. The idea is similar to
> napi_synchronize. The series contains fixes for the drivers that
> implement XSK. I haven't tested the changes to Intel's drivers, so,
> Intel guys, please review them.
>

Max, thanks a lot for compiling the series on your vacation!


Cheers,
Bj?rn
