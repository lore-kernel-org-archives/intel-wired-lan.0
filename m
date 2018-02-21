From: Ray Bellis <ray@isc.org>
Date: Wed, 21 Feb 2018 16:56:44 +0000
Subject: [Intel-wired-lan] X710 disable flow hashing?
In-Reply-To: <CAKgT0UcfHEWkfp3gBKqC4yG8umcEctsgq3ty+OJvJw6GgAXv7Q@mail.gmail.com>
References: <1d4c6e02-2800-1ecb-4e6d-88410837ff8c@isc.org>
 <CAKgT0UdBA9KiCx93xfsYLpw3HhEx+kc1kasR5rRcD5Nekd6Ynw@mail.gmail.com>
 <4709cf54-5c87-d499-65dc-f420e8efb4ae@isc.org>
 <f61e07b4-6728-e636-97bf-6ed9252b23bb@isc.org>
 <CAKgT0UcfHEWkfp3gBKqC4yG8umcEctsgq3ty+OJvJw6GgAXv7Q@mail.gmail.com>
Message-ID: <eaa15cc5-887c-c5e2-ffce-2c5a28d18b8f@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 21/02/2018 16:53, Alexander Duyck wrote:

> I don't think the X710 supports bitmasking of the port. You should be
> able to mask in/out the entire source or destination port but I don't
> think it supports just masking out part of them.

That's what I've found - using Flow Director on individual ports are
fine, but using a mask generates "Operation not supported".

If that's a limitation of the card that's going to be a PITA...

Ray
