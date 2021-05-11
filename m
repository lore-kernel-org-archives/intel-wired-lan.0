From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 11 May 2021 19:22:49 +0200
Subject: [Intel-wired-lan] [PATCH 5/5] docs: networking: device_drivers:
 fix bad usage of UTF-8 chars
In-Reply-To: <95eb2a48d0ca3528780ce0dfce64359977fa8cb3.1620744606.git.mchehab+huawei@kernel.org>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
 <95eb2a48d0ca3528780ce0dfce64359977fa8cb3.1620744606.git.mchehab+huawei@kernel.org>
Message-ID: <YJq9abOeuBla3Jiw@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
> +monitoring tools such as `ifstat` or `sar -n DEV [interval] [number of samples]`

...

>  For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using network
> -monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
> +monitoring tools such as ``ifstat`` or ``sar -n DEV [interval] [number of samples]``

Is there a difference between ` and `` ? Does it make sense to be
consistent?

	Andrew
