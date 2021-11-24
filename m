From: Kris Karas (Bug reporting) <bugs-a21@moonlit-rail.com>
Date: Wed, 24 Nov 2021 17:32:04 -0500
Subject: [Intel-wired-lan] [PATCH net v2] igb: fix netpoll exit with
 traffic
In-Reply-To: <20211123204000.1597971-1-jesse.brandeburg@intel.com>
References: <20211123204000.1597971-1-jesse.brandeburg@intel.com>
Message-ID: <480a6f82-99c4-ad46-3878-6bb442d81496@moonlit-rail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jesse Brandeburg wrote:
> Oleksandr brought a bug report where netpoll causes trace
> messages in the log on igb.
> ---
> -	return min(work_done, budget - 1);
> +	return work_done;

I am able to reproduce the WARNING + stack trace at will.? It occurs on 
every boot.
Please see https://bugzilla.kernel.org/show_bug.cgi?id=212573 for details.

I have tested the simple patch (v2) against both kernels 5.14 and 5.15, 
and am happy to report that this fixes the issue for me.

Kris

